---
description: Health-check AI Desk and auto-repair anything out of sync
---

Run the full self-maintenance pass described in `docs/maintenance.md` and `docs/self-healing.md`:

1. Inventory `docs/`, `.opencode/agents/`, `.opencode/skills/`, `.opencode/commands/`.
2. Reconcile `docs/index.md` and `docs/catalog.md` with what actually exists — fix drift.
3. Check `CLAUDE.md` is under its size budget and all its links resolve.
4. Validate frontmatter on every agent and skill.
5. Confirm `profile/profile.md` exists (or note that the user should run `init`).

Apply safe fixes yourself. Ask before anything destructive. Finish with a short, plain-language
report of what you found and what you changed.
