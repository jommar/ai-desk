# Maintenance & `/checkup`

Routine housekeeping that keeps AI Desk healthy. Most of it happens automatically as a side effect of
the self-healing rules; `/checkup` runs the full pass on demand.

## What `/checkup` does

Runs the repair procedure in `self-healing.md` end to end and reports results:

1. **Inventory** — lists what's actually in `docs/`, `agents/`, `skills/`, `commands/`.
2. **Consistency** — reconciles `docs/index.md` and `docs/catalog.md` with that inventory; fixes
   drift.
3. **`AGENTS.md` health** — checks the size budget, that every link resolves, and that the
   per-harness pointers stay thin.
4. **Definitions** — validates frontmatter on every agent and skill.
5. **Profile** — confirms `profile/profile.md` exists (or nudges the user to run `init`).
6. **Report** — a short summary of what was found and fixed, in plain language.

Output should read like: _"All good — 4 assistants, 4 tools, everything in sync."_ or _"Fixed 2
things: added `weekly-report` to the catalog, trimmed AGENTS.md back under budget."_

## Good times to run it

- After building a new assistant or tool.
- After renaming or deleting anything.
- If something feels off or out of sync.
- Occasionally, just to stay tidy.

## Keeping the profile fresh

Whenever you learn something durable about the user (a new client, a changed preference, a new rule),
update `profile/profile.md` and note the change. This isn't a separate chore — do it inline as you
work.

## Housekeeping the workspace

`workspace/` is the user's. Don't prune it automatically. If it's getting cluttered, you may *offer*
to organize it into subfolders (e.g. by month or project), but only act with a clear yes.

## Optional deterministic check

`checkup` is the conversational health pass. Operators who want a scriptable, model-free version can
run `bash scripts/validate.sh`, which checks the same self-healing invariants (AGENTS.md size, index
and catalog in sync, frontmatter, valid settings, resolving links) and exits non-zero on failure. CI
runs it on pull requests. It's a convenience, never a requirement.

## No build step for end users

AI Desk has no compiler, package manager, or required CI. **End users install nothing** — the
per-harness adapter files are committed, so cloning the repo and opening it in any tool just works.

**Contributors** have one optional step: after editing a source file (`AGENTS.md`, `agents/`,
`skills/`, `commands/`, or the permission posture), run `python3 scripts/sync-harnesses.py` to
regenerate the harness adapters (see `harnesses.md`). `scripts/validate.sh` and CI check that the
generated files match the source. The generator uses only the Python 3 standard library — no
`pip install`. The optional `scripts/validate.sh` and the GitHub Actions workflow are conveniences
for operators; the product must keep working without them.
