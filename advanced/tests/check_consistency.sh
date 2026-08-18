#!/bin/bash
#
# Checks that the slides, the exercises and the diagrams still agree with each other.
#
# The 2026 content update existed largely because the slides were refreshed and the
# exercises were not. This script exists so that cannot happen quietly again.
#
# Run it from anywhere; it works on the repository it lives in.

set -uo pipefail

repo_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )
cd "$repo_root" || exit 1

status=0

fail () {
    echo "  FAIL: $1"
    status=1
}

pass () {
    echo "  ok: $1"
}

echo "1. Every exercise referenced in the slides exists"
missing=0
# shellcheck disable=SC2013 # word-splitting is fine: these are bare numbers, never paths
for n in $(grep -oE 'Exercise [0-9]+' advanced/slides/slides.md | grep -oE '[0-9]+' | sort -u); do
    if ! ls advanced/Exercise_"$n"_*.md > /dev/null 2>&1; then
        fail "slides mention Exercise $n, but no advanced/Exercise_${n}_*.md exists"
        missing=1
    fi
done
[ "$missing" -eq 0 ] && pass "all exercises referenced by the slides are present"

echo "2. Every exercise on disk is referenced in the slides"
missing=0
for f in advanced/Exercise_*.md; do
    n=$(basename "$f" | sed 's/Exercise_\([0-9]*\)_.*/\1/')
    if ! grep -q "Exercise $n" advanced/slides/slides.md; then
        fail "$f exists, but the slides never mention Exercise $n"
        missing=1
    fi
done
[ "$missing" -eq 0 ] && pass "all exercises on disk are referenced by the slides"

echo "3. Every image used by the slides has a Mermaid source"
missing=0
# shellcheck disable=SC2013 # word-splitting is fine: these are single-token image paths
for img in $(grep -oE 'images/[A-Za-z0-9_-]+\.svg' advanced/slides/slides.md | sort -u); do
    name=$(basename "$img" .svg)
    [ -f "advanced/slides/$img" ] || { fail "slides reference $img, which does not exist"; missing=1; }
    [ -f "advanced/slides/diagrams/$name.mmd" ] || { fail "$img has no diagrams/$name.mmd source"; missing=1; }
done
[ "$missing" -eq 0 ] && pass "every referenced diagram has a source and a rendered SVG"

echo "4. No orphaned Mermaid sources"
missing=0
for f in advanced/slides/diagrams/*.mmd; do
    name=$(basename "$f" .mmd)
    grep -q "images/$name.svg" advanced/slides/slides.md || { fail "$f is never used by the slides"; missing=1; }
done
[ "$missing" -eq 0 ] && pass "no orphaned diagram sources"

echo "5. No raster images left in the slides folder"
missing=0
shopt -s nullglob
for f in advanced/slides/images/*.png advanced/slides/images/*.jpg advanced/slides/images/*.jpeg advanced/slides/images/*.gif; do
    fail "$f is a raster image; diagrams should be Mermaid-generated SVG"
    missing=1
done
shopt -u nullglob
[ "$missing" -eq 0 ] && pass "all slide images are SVG"

echo "6. Internal Markdown links resolve"
python3 - <<'PY' || status=1
import re, os, glob, sys
bad = 0
for f in glob.glob('**/*.md', recursive=True):
    if '/node_modules/' in f or f.startswith('.git/'):
        continue
    base = os.path.dirname(f)
    txt = open(f, encoding='utf-8').read()
    for m in re.finditer(r'\[[^\]]*\]\(([^)#\s]+)(#[^)]*)?\)', txt):
        target = m.group(1)
        if target.startswith(('http://', 'https://', 'mailto:')):
            continue
        p = os.path.normpath(os.path.join(base, target))
        if not os.path.exists(p):
            print(f"  FAIL: {f} links to {target}, which does not exist")
            bad += 1
if bad == 0:
    print("  ok: every internal Markdown link resolves")
sys.exit(1 if bad else 0)
PY

echo "7. In-page anchors resolve"
python3 - <<'PY' || status=1
import re, os, glob, sys

def anchors(text):
    names = set(re.findall(r'<a name="([^"]+)"', text))
    for h in re.findall(r'^#+\s+(.+)$', text, re.M):
        slug = re.sub(r'[^\w\s-]', '', h.lower()).strip().replace(' ', '-')
        names.add(slug)
    return names

bad = 0
for f in glob.glob('**/*.md', recursive=True):
    if '/node_modules/' in f or f.startswith('.git/'):
        continue
    txt = open(f, encoding='utf-8').read()
    own = anchors(txt)
    for m in re.finditer(r'\]\(#([^)]+)\)', txt):
        if m.group(1) not in own:
            print(f"  FAIL: {f} links to #{m.group(1)}, which has no matching anchor")
            bad += 1
    for m in re.finditer(r'\]\(([^)#\s]+\.md)#([^)]+)\)', txt):
        p = os.path.normpath(os.path.join(os.path.dirname(f), m.group(1)))
        if not os.path.exists(p):
            continue
        if m.group(2) not in anchors(open(p, encoding='utf-8').read()):
            print(f"  FAIL: {f} links to {m.group(1)}#{m.group(2)}, which has no matching anchor")
            bad += 1
if bad == 0:
    print("  ok: every in-page anchor resolves")
sys.exit(1 if bad else 0)
PY

echo "8. The exercise table in advanced/README.md is complete"
missing=0
for f in advanced/Exercise_*.md; do
    grep -q "$(basename "$f")" advanced/README.md || { fail "$(basename "$f") is missing from the table in advanced/README.md"; missing=1; }
done
[ "$missing" -eq 0 ] && pass "advanced/README.md lists every exercise"

# The two checks below only cover advanced/ plus the root files this course update
# owns. The beginner course uses trailing two spaces deliberately, for Markdown hard
# line breaks, in a lot of its prose - a repo-wide rule would misfire on it constantly,
# and reformatting that content is a separate piece of work from this one.
scoped_files=$(git -C "$repo_root" ls-files -- 'advanced/*.md' 'advanced/*.sh' 2>/dev/null)
scoped_files="$scoped_files
README.md
Expert_Topics.md
check_requirements.sh"

echo "9. No accidental trailing whitespace in advanced/ (two-space hard breaks allowed)"
missing=0
while IFS= read -r f; do
    [ -f "$f" ] || continue
    # A line ending in exactly two spaces is a deliberate Markdown hard break; anything
    # else with trailing whitespace (tabs, one space, three or more spaces) is a slip.
    # [[:blank:]] rather than [ \t]: inside a bracket expression, "\t" is not
    # guaranteed to mean tab and can instead match a literal backslash or "t".
    hit=$(grep -nE '[[:blank:]]+$' "$f" | grep -vE '^[0-9]+:.*[^ ]  $')
    if [ -n "$hit" ]; then
        fail "$f has trailing whitespace that is not a two-space hard break"
        missing=1
    fi
done <<< "$scoped_files"
[ "$missing" -eq 0 ] && pass "no accidental trailing whitespace"

echo "10. Every file ends with a newline"
missing=0
while IFS= read -r f; do
    [ -f "$f" ] || continue
    if [ -n "$(tail -c 1 "$f")" ]; then
        fail "$f does not end with a newline"
        missing=1
    fi
done <<< "$scoped_files"
[ "$missing" -eq 0 ] && pass "every file ends with a newline"

echo
if [ "$status" -eq 0 ]; then
    echo "All consistency checks passed."
else
    echo "Consistency checks FAILED."
fi
exit $status
