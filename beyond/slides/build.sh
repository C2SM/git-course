#!/bin/bash
#
# Builds the beyond course slides: renders every Mermaid diagram to SVG, then
# renders the deck to HTML and PDF. The CI workflows run this same script, so a
# local build and the committed PDF cannot drift apart, and the site published to
# GitHub Pages is built exactly the way authors build it locally.
#
# Requires Node.js. Everything else is fetched by npx on demand.

set -euo pipefail

repo_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )
cd "$repo_root"

diagrams="beyond/slides/diagrams"
images="beyond/slides/images"
hashes="$images/.diagram-hashes"

mkdir -p "$images"
touch "$hashes"

# sha256sum is a GNU coreutils tool and isn't on macOS by default; shasum ships there instead.
sha256() {
    if command -v sha256sum &> /dev/null; then
        sha256sum
    else
        shasum -a 256
    fi
}

echo "Rendering Mermaid diagrams..."
new_hashes=$(mktemp)
for src in "$diagrams"/*.mmd; do
    name=$(basename "$src" .mmd)

    # Hash the diagram together with the config, since a config change affects every
    # diagram's output. Skip re-rendering (and re-launching a headless browser) when
    # neither has changed since the last build and the SVG is already up to date.
    hash=$(cat "$src" "$diagrams/mermaid-config.json" "$diagrams/puppeteer-config.json" | sha256 | awk '{print $1}')
    echo "$name $hash" >> "$new_hashes"

    if [[ -f "$images/$name.svg" ]] && grep -qx "$name $hash" "$hashes"; then
        echo "  $name (unchanged, skipped)"
        continue
    fi

    echo "  $name"
    npx -y @mermaid-js/mermaid-cli@11 \
        --input "$src" \
        --output "$images/$name.svg" \
        --configFile "$diagrams/mermaid-config.json" \
        --puppeteerConfigFile "$diagrams/puppeteer-config.json" \
        --backgroundColor transparent \
        --quiet

    # Mermaid gives a gitGraph cherry-pick commit a randomly generated id, which ends
    # up in a CSS class name. It has no effect on how the diagram looks, but it makes
    # the SVG differ on every build, so CI would commit a "changed" file every run.
    # Normalize it to keep the output reproducible.
    # No sed -i here: BSD sed on macOS requires an argument to it.
    tmp=$(mktemp)
    sed -E 's/(class="commit [0-9]+)-[0-9a-f]{7}/\1/g' "$images/$name.svg" > "$tmp" \
        && mv "$tmp" "$images/$name.svg"
done
mv "$new_hashes" "$hashes"

# Unlike mermaid-cli, marp-cli does not ship a browser: it needs Chrome, Edge or
# Firefox on the system. CI runners have one, many local machines (e.g. WSL) do not,
# so fall back to the Chrome that puppeteer downloads into its own cache.
have_browser=false
for browser in google-chrome google-chrome-stable chromium chromium-browser microsoft-edge firefox; do
    command -v "$browser" &> /dev/null && have_browser=true && break
done

if [[ -z "${CHROME_PATH:-}" ]] && [[ "$have_browser" == false ]]; then
    echo "No system browser found, using puppeteer's Chrome..."
    CHROME_PATH=$(npx -y @puppeteer/browsers install chrome@stable --path "${HOME}/.cache/puppeteer" | awk '{print $NF}')
    export CHROME_PATH
fi

# The HTML deck carries the presenter notes: Marp turns every non-directive comment
# in slides.md into a note, shown in the presenter view (press "p"). The PDF renderer
# drops them, so the notes stay out of the handout.
echo "Rendering slides to HTML..."
html="beyond/slides/slides_beyond.html"
npx -y @marp-team/marp-cli@latest beyond/slides/slides.md \
    --config-file slides_theme/marprc.yml \
    --theme-set slides_theme/c2sm-light.css slides_theme/c2sm-dark.css \
    --allow-local-files \
    -o "$html"

echo "Rendering slides to PDF..."
pdf="beyond/slides/slides_beyond.pdf"
npx -y @marp-team/marp-cli@latest beyond/slides/slides.md \
    --config-file slides_theme/marprc.yml \
    --theme-set slides_theme/c2sm-light.css slides_theme/c2sm-dark.css \
    --pdf \
    --allow-local-files \
    -o "$pdf"

# Two sources make the PDF differ byte-for-byte between runs even when nothing
# changed, which would make CI commit a "changed" PDF every time:
#  - Marp stamps CreationDate/ModDate with the current time.
#  - Headless Chrome numbers the tagged-PDF accessibility structure tree with
#    "node<N>" ids drawn from a per-run counter, unrelated to the document content.
# Pin the dates and renumber the node ids deterministically to keep the output
# reproducible.
normalize_tmp=$(mktemp -d)
npm install --no-audit --no-fund --silent --prefix "$normalize_tmp" pdf-lib@1
NODE_PATH="$normalize_tmp/node_modules" node - "$pdf" <<'NODE'
const fs = require("fs");
const { PDFDocument, PDFDict, PDFArray, PDFStream, PDFString } = require("pdf-lib");

const NODE_ID_RE = /^node\d+$/;

(async () => {
    const path = process.argv[2];
    const doc = await PDFDocument.load(fs.readFileSync(path));
    doc.setCreationDate(new Date(0));
    doc.setModificationDate(new Date(0));

    const renumbered = new Map();
    const nextId = (oldId) => {
        if (!renumbered.has(oldId)) {
            renumbered.set(oldId, `node${String(renumbered.size).padStart(8, "0")}`);
        }
        return renumbered.get(oldId);
    };

    // Structure tree node ids are referenced from many objects scattered across
    // the document, so walk every indirect object and rewrite each occurrence to
    // a value based only on the order it is first encountered while enumerating
    // objects in ascending, and therefore stable, object-number order.
    const visit = (obj, set) => {
        if (obj instanceof PDFString) {
            const value = obj.asString();
            if (NODE_ID_RE.test(value)) set(PDFString.of(nextId(value)));
        } else if (obj instanceof PDFDict) {
            for (const [key, value] of obj.entries()) visit(value, (v) => obj.set(key, v));
        } else if (obj instanceof PDFArray) {
            for (let i = 0; i < obj.size(); i++) visit(obj.get(i), (v) => obj.set(i, v));
        } else if (obj instanceof PDFStream) {
            visit(obj.dict, () => {});
        }
    };
    for (const [, object] of doc.context.enumerateIndirectObjects()) visit(object, () => {});

    fs.writeFileSync(path, await doc.save());
})();
NODE
rm -rf "$normalize_tmp"

echo "Done: $html, $pdf"
