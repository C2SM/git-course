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

# Marp stamps the PDF's CreationDate/ModDate with the current time on every build,
# which makes the file differ byte-for-byte even when nothing changed. That causes
# CI to commit a "changed" PDF on every run. Pin both dates to the epoch to keep
# the output reproducible.
normalize_tmp=$(mktemp -d)
npm install --no-audit --no-fund --silent --prefix "$normalize_tmp" pdf-lib@1
NODE_PATH="$normalize_tmp/node_modules" node - "$pdf" <<'NODE'
const fs = require("fs");
const { PDFDocument } = require("pdf-lib");

(async () => {
    const path = process.argv[2];
    const doc = await PDFDocument.load(fs.readFileSync(path));
    doc.setCreationDate(new Date(0));
    doc.setModificationDate(new Date(0));
    fs.writeFileSync(path, await doc.save());
})();
NODE
rm -rf "$normalize_tmp"

echo "Done: $html, $pdf"
