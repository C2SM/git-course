#!/bin/bash
#
# Builds the beginner course slides deck to HTML and PDF. The CI workflows run this
# same script, so a local build and the committed PDF cannot drift apart, and the
# site published to GitHub Pages is built exactly the way authors build it locally.
#
# Requires Node.js. Everything else is fetched by npx on demand.

set -euo pipefail

repo_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )
cd "$repo_root"

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
html="beginner/slides/slides_beginner.html"
npx -y @marp-team/marp-cli@latest beginner/slides/slides.md \
    --config-file slides_theme/marprc.yml \
    --theme-set slides_theme/c2sm-light.css slides_theme/c2sm-dark.css \
    --allow-local-files \
    -o "$html"

echo "Rendering slides to PDF..."
pdf="beginner/slides/slides_beginner.pdf"
npx -y @marp-team/marp-cli@latest beginner/slides/slides.md \
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
