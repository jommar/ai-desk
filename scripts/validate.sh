#!/usr/bin/env bash
#
# validate.sh — deterministic check of AI Desk's self-healing invariants.
#
# OPTIONAL. AI Desk works with zero install; this script is a convenience for
# operators and CI. It mirrors what `checkup` does, but without a model:
#
#   1. AGENTS.md is within its size budget (<= 130 lines).
#   2. Every doc in docs/ is listed in docs/index.md.
#   3. Every installed agent, skill, and command appears in docs/catalog.md.
#   4. Every agent and skill has `name` + `description` frontmatter.
#   5. Any shipped harness permission config is valid JSON.
#   6. Every docs/ link referenced in AGENTS.md resolves to a real file.
#   7. Per-harness entry pointers are thin (they redirect to AGENTS.md).
#   8. Generated harness adapters are in sync with the source (needs python3).
#
# AI Desk is harness-agnostic: content lives once in agents/, skills/, commands/,
# and AGENTS.md is the single source of truth; scripts/sync-harnesses.py generates
# each harness's native dirs from it. See docs/harnesses.md.
#
# Dependencies: bash + coreutils. Uses python3 for JSON validation and the adapter
# sync check if present.
# Exit code 0 = all good; 1 = one or more checks failed.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
cd "$ROOT" || exit 2

AGENTS_MAX_LINES=130
fail=0
pass_count=0

red()   { printf '\033[31m%s\033[0m\n' "$1"; }
green() { printf '\033[32m%s\033[0m\n' "$1"; }

ok()   { green "  ok   $1"; pass_count=$((pass_count + 1)); }
bad()  { red   "  FAIL $1"; fail=$((fail + 1)); }

echo "AI Desk validation — $ROOT"
echo

# --- 1. AGENTS.md size budget ------------------------------------------------
echo "[1] AGENTS.md size budget (<= ${AGENTS_MAX_LINES} lines)"
if [ -f AGENTS.md ]; then
  lines=$(wc -l < AGENTS.md | tr -d ' ')
  if [ "$lines" -le "$AGENTS_MAX_LINES" ]; then
    ok "AGENTS.md is $lines lines"
  else
    bad "AGENTS.md is $lines lines (budget $AGENTS_MAX_LINES) — move detail into docs/"
  fi
else
  bad "AGENTS.md not found"
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
  for f in agents/*.md; do
    [ -e "$f" ] || continue
    name="$(basename "$f" .md)"
    if grep -qF "$name" docs/catalog.md; then ok "agent $name in catalog"
    else bad "agent $name missing from catalog"; fi
  done
  for d in skills/*/; do
    [ -e "$d" ] || continue
    name="$(basename "$d")"
    if grep -qF "$name" docs/catalog.md; then ok "skill $name in catalog"
    else bad "skill $name missing from catalog"; fi
  done
  for f in commands/*.md; do
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
for f in agents/*.md; do [ -e "$f" ] && check_frontmatter "$f"; done
for f in skills/*/SKILL.md; do [ -e "$f" ] && check_frontmatter "$f"; done
echo

# --- 5. Harness permission configs are valid JSON ----------------------------
echo "[5] Harness permission configs are valid JSON"
json_configs=(.claude/settings.json .opencode/opencode.json)
found_any=0
for cfg in "${json_configs[@]}"; do
  [ -f "$cfg" ] || continue
  found_any=1
  if command -v python3 >/dev/null 2>&1; then
    if python3 -c "import json,sys; json.load(open('$cfg'))" 2>/dev/null; then
      ok "$cfg parses"
    else
      bad "$cfg is not valid JSON"
    fi
  else
    green "  skip $cfg check (python3 not available)"
  fi
done
[ "$found_any" -eq 0 ] && green "  note no harness permission configs present (optional)"
echo

# --- 6. AGENTS.md doc links resolve ------------------------------------------
echo "[6] AGENTS.md links to docs/ resolve"
if [ -f AGENTS.md ]; then
  refs="$(grep -oE 'docs/[a-zA-Z0-9_/-]+\.md' AGENTS.md | sort -u)"
  if [ -z "$refs" ]; then
    green "  note no docs/ links found in AGENTS.md"
  else
    while IFS= read -r ref; do
      [ -z "$ref" ] && continue
      if [ -f "$ref" ]; then ok "$ref"
      else bad "$ref referenced in AGENTS.md but not found"; fi
    done <<< "$refs"
  fi
fi
echo

# --- 7. Per-harness entry pointers stay thin ---------------------------------
echo "[7] Per-harness pointers redirect to AGENTS.md"
pointers=(CLAUDE.md GEMINI.md .github/copilot-instructions.md .cursor/rules/ai-desk.mdc)
for p in "${pointers[@]}"; do
  [ -f "$p" ] || continue
  if grep -qF "AGENTS.md" "$p"; then ok "$p points to AGENTS.md"
  else bad "$p exists but does not reference AGENTS.md (should be a thin pointer)"; fi
done
echo

# --- 8. Generated harness adapters are in sync with the source ---------------
echo "[8] Generated harness adapters match the source (sync-harnesses.py --check)"
if [ -f scripts/sync-harnesses.py ]; then
  if command -v python3 >/dev/null 2>&1; then
    if python3 scripts/sync-harnesses.py --check >/dev/null 2>&1; then
      ok "harness adapters in sync"
    else
      bad "harness adapters are stale — run: python3 scripts/sync-harnesses.py"
    fi
  else
    green "  skip adapter sync check (python3 not available)"
  fi
else
  green "  note no generator present (scripts/sync-harnesses.py)"
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
