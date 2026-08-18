#!/bin/bash
#
# Builds the advanced course slides: renders every Mermaid diagram to SVG, then
# renders the deck to PDF. The CI workflow runs this same script, so a local build
# and the committed PDF cannot drift apart.
#
# Requires Node.js. Everything else is fetched by npx on demand.

set -euo pipefail

repo_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )
cd "$repo_root"

diagrams="advanced/slides/diagrams"
images="advanced/slides/images"

mkdir -p "$images"

echo "Rendering Mermaid diagrams..."
for src in "$diagrams"/*.mmd; do
    name=$(basename "$src" .mmd)
    echo "  $name"
    npx -y @mermaid-js/mermaid-cli@11 \
        --input "$src" \
        --output "$images/$name.svg" \
        --configFile "$diagrams/mermaid-config.json" \
        --puppeteerConfigFile "$diagrams/puppeteer-config.json" \
        --backgroundColor transparent \
        --quiet
done

echo "Rendering slides to PDF..."
npx -y @marp-team/marp-cli@latest advanced/slides/slides.md \
    --theme-set slides_theme/c2sm-light.css slides_theme/c2sm-dark.css \
    --pdf \
    --allow-local-files \
    -o advanced/slides/slides_advanced.pdf

echo "Done: advanced/slides/slides_advanced.pdf"
