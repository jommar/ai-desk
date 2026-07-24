<!-- Thanks for contributing to AI Desk. Keep changes surgical and the repo in sync. -->

## What & why

<!-- What does this change and why? Keep it short. -->

## Self-healing checklist

<!-- Required if you added, renamed, or removed an agent, skill, command, or doc. -->

- [ ] `docs/index.md` lists every doc (and nothing stale).
- [ ] `docs/catalog.md` matches `agents/`, `skills/`, `commands/`.
- [ ] New/changed agents & skills have `name` + `description` frontmatter.
- [ ] `AGENTS.md` is still ≤130 lines and its links resolve; per-harness pointers stay thin.
- [ ] Edited the **source** (`agents/`/`skills/`/`commands/`), not generated adapters; ran
      `python3 scripts/sync-harnesses.py` and committed the regenerated adapters.
- [ ] `bash scripts/validate.sh` passes (or `checkup` is clean).
- [ ] End-user zero-install preserved: no new dependency required to *use* AI Desk.
- [ ] User-facing text stays plain and warm; safety model (draft-first) intact.
