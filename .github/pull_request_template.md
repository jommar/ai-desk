<!-- Thanks for contributing to AI Desk. Keep changes surgical and the repo in sync. -->

## What & why

<!-- What does this change and why? Keep it short. -->

## Self-healing checklist

<!-- Required if you added, renamed, or removed an agent, skill, command, or doc. -->

- [ ] `docs/index.md` lists every doc (and nothing stale).
- [ ] `docs/catalog.md` matches `.claude/agents/`, `.claude/skills/`, `.claude/commands/`.
- [ ] New/changed agents & skills have `name` + `description` frontmatter.
- [ ] `CLAUDE.md` is still ≤110 lines and its links resolve.
- [ ] `bash scripts/validate.sh` passes (or `/checkup` is clean).
- [ ] Zero-install preserved: no new required dependencies or build step.
- [ ] User-facing text stays plain and warm; safety model (draft-first) intact.
