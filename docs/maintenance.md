# Maintenance & `/checkup`

Routine housekeeping that keeps AI Desk healthy. Most of it happens automatically as a side effect of
the self-healing rules; `/checkup` runs the full pass on demand.

## What `/checkup` does

Runs the repair procedure in `self-healing.md` end to end and reports results:

1. **Inventory** — lists what's actually in `docs/`, `.claude/agents/`, `.claude/skills/`,
   `.claude/commands/`.
2. **Consistency** — reconciles `docs/index.md` and `docs/catalog.md` with that inventory; fixes
   drift.
3. **`CLAUDE.md` health** — checks the size budget and that every link resolves.
4. **Definitions** — validates frontmatter on every agent and skill.
5. **Profile** — confirms `profile/profile.md` exists (or nudges the user to run `init`).
6. **Report** — a short summary of what was found and fixed, in plain language.

Output should read like: _"All good — 4 assistants, 4 tools, everything in sync."_ or _"Fixed 2
things: added `weekly-report` to the catalog, trimmed CLAUDE.md back under budget."_

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

## Deliberately no build step

AI Desk has no compiler, package manager, or CI to maintain. If an advanced operator wants linting or
git hooks, that's optional and lives in their own config — the product must keep working without it.
