#!/usr/bin/env bash
#
# validate.sh — deterministic check of AI Desk's self-healing invariants.
#
# OPTIONAL. AI Desk works with zero install; this script is a convenience for
# operators and CI. It mirrors what `/checkup` does, but without a model:
#
#   1. CLAUDE.md is within its size budget (<= 110 lines).
#   2. Every doc in docs/ is listed in docs/index.md.
#   3. Every installed agent, skill, and command appears in docs/catalog.md.
#   4. Every agent and skill has `name` + `description` frontmatter.
#   5. .claude/settings.json is valid JSON.
#   6. Every docs/ link referenced in CLAUDE.md resolves to a real file.
#
# Dependencies: bash + coreutils. Uses python3 for JSON validation if present.
# Exit code 0 = all good; 1 = one or more checks failed.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
cd "$ROOT" || exit 2

CLAUDE_MAX_LINES=110
fail=0
pass_count=0

red()   { printf '\033[31m%s\033[0m\n' "$1"; }
green() { printf '\033[32m%s\033[0m\n' "$1"; }

ok()   { green "  ok   $1"; pass_count=$((pass_count + 1)); }
bad()  { red   "  FAIL $1"; fail=$((fail + 1)); }

echo "AI Desk validation — $ROOT"
echo

# --- 1. CLAUDE.md size budget -------------------------------------------------
echo "[1] CLAUDE.md size budget (<= ${CLAUDE_MAX_LINES} lines)"
if [ -f CLAUDE.md ]; then
  lines=$(wc -l < CLAUDE.md | tr -d ' ')
  if [ "$lines" -le "$CLAUDE_MAX_LINES" ]; then
    ok "CLAUDE.md is $lines lines"
  else
    bad "CLAUDE.md is $lines lines (budget $CLAUDE_MAX_LINES) — move detail into docs/"
  fi
else
  bad "CLAUDE.md not found"
fi
echo

# --- 2. Every doc is listed in docs/index.md ---------------------------------
echo "[2] docs/index.md lists every doc"
if [ -f docs/index.md ]; then
  while IFS= read -r doc; do
    rel="${doc#docs/}"
    [ "$rel" = "index.md" ] && continue
    if grep -qF "$rel" docs/index.md; then
      ok "$rel listed"
    else
      bad "$rel is missing from docs/index.md"
    fi
  done < <(find docs -type f -name '*.md' | sort)
else
  bad "docs/index.md not found"
fi
echo

# --- 3. Catalog matches installed agents / skills / commands -----------------
echo "[3] docs/catalog.md matches what's installed"
if [ -f docs/catalog.md ]; then
  for f in .claude/agents/*.md; do
    [ -e "$f" ] || continue
    name="$(basename "$f" .md)"
    if grep -qF "$name" docs/catalog.md; then ok "agent $name in catalog"
    else bad "agent $name missing from catalog"; fi
  done
  for d in .claude/skills/*/; do
    [ -e "$d" ] || continue
    name="$(basename "$d")"
    if grep -qF "$name" docs/catalog.md; then ok "skill $name in catalog"
    else bad "skill $name missing from catalog"; fi
  done
  for f in .claude/commands/*.md; do
    [ -e "$f" ] || continue
    name="$(basename "$f" .md)"
    if grep -qF "/$name" docs/catalog.md; then ok "command /$name in catalog"
    else bad "command /$name missing from catalog"; fi
  done
else
  bad "docs/catalog.md not found"
fi
echo

# --- 4. Agent / skill frontmatter --------------------------------------------
echo "[4] Agents & skills have name + description frontmatter"
check_frontmatter() {
  local f="$1" head
  head="$(head -n 10 "$f")"
  local missing=""
  echo "$head" | grep -qE '^name:[[:space:]]*[^[:space:]]' || missing="name"
  echo "$head" | grep -qE '^description:[[:space:]]*[^[:space:]]' \
    || missing="${missing:+$missing, }description"
  if [ -z "$missing" ]; then ok "$f"
  else bad "$f is missing frontmatter: $missing"; fi
}
for f in .claude/agents/*.md; do [ -e "$f" ] && check_frontmatter "$f"; done
for f in .claude/skills/*/SKILL.md; do [ -e "$f" ] && check_frontmatter "$f"; done
echo

# --- 5. settings.json is valid JSON ------------------------------------------
echo "[5] .claude/settings.json is valid JSON"
if [ -f .claude/settings.json ]; then
  if command -v python3 >/dev/null 2>&1; then
    if python3 -c "import json,sys; json.load(open('.claude/settings.json'))" 2>/dev/null; then
      ok "settings.json parses"
    else
      bad "settings.json is not valid JSON"
    fi
  else
    green "  skip settings.json check (python3 not available)"
  fi
else
  bad ".claude/settings.json not found"
fi
echo

# --- 6. CLAUDE.md doc links resolve ------------------------------------------
echo "[6] CLAUDE.md links to docs/ resolve"
if [ -f CLAUDE.md ]; then
  # Extract references like docs/foo.md or docs/builder/bar.md
  refs="$(grep -oE 'docs/[a-zA-Z0-9_/-]+\.md' CLAUDE.md | sort -u)"
  if [ -z "$refs" ]; then
    green "  note no docs/ links found in CLAUDE.md"
  else
    while IFS= read -r ref; do
      [ -z "$ref" ] && continue
      if [ -f "$ref" ]; then ok "$ref"
      else bad "$ref referenced in CLAUDE.md but not found"; fi
    done <<< "$refs"
  fi
fi
echo

# --- Summary -----------------------------------------------------------------
echo "-----------------------------------------------"
if [ "$fail" -eq 0 ]; then
  green "All checks passed ($pass_count ok)."
  exit 0
else
  red "$fail check(s) failed, $pass_count ok."
  exit 1
fi
