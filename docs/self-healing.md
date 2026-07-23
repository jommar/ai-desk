# Self-Healing Rules

AI Desk is meant to run for a long time without anyone "fixing" it. These rules keep it consistent
and keep `CLAUDE.md` lean. Apply them automatically whenever you touch the repo, and in full during
`/checkup`.

## The core principle

**`CLAUDE.md` is a router, not a library.** It holds only: the start-here behavior, the routing
table, the golden rules, and the self-maintenance pointer. Every real explanation lives in `docs/`.
Knowledge grows in `docs/`; `CLAUDE.md` stays small.

## Invariants (what must always be true)

1. **`CLAUDE.md` is under its size budget** (~110 lines). If it's over, move detail into the right
   doc and leave a one-line pointer.
2. **No inlined docs in `CLAUDE.md`.** If you catch yourself pasting procedure into it, stop — put it
   in a doc and link it.
3. **`docs/index.md` lists every file in `docs/`** (and nothing that no longer exists).
4. **`docs/catalog.md` matches reality** — every file in `.claude/agents/` and every folder in
   `.claude/skills/` appears in the catalog, and every catalog row points to something real.
5. **Every agent/skill has valid frontmatter** — see `builder/agent-design.md` and
   `builder/skill-design.md` for the required fields.
6. **Commands referenced in docs exist** in `.claude/commands/` (and vice-versa for the ones users
   are told about).
7. **The profile exists or the user is invited to run `init`.** Never operate as if a profile you
   never read is present.

## When to self-heal

- **After any change** you make to agents, skills, commands, or docs — update the index/catalog in
  the same turn.
- **When you notice drift** — a broken pointer, a renamed file, a missing catalog row — fix it then,
  don't wait.
- **On demand** — the user runs `/checkup`.

## The repair procedure

1. **Inventory** what actually exists: list `docs/`, `.claude/agents/`, `.claude/skills/`,
   `.claude/commands/`.
2. **Reconcile** against `docs/index.md` and `docs/catalog.md`. Add missing rows, remove stale ones,
   fix names/links.
3. **Check `CLAUDE.md`**: is it under budget? Are all its links valid? Trim and re-point as needed.
4. **Validate frontmatter** on each agent/skill; flag or fix anything malformed.
5. **Confirm the profile** situation.
6. **Report** what you changed in a short, plain-language summary. Fix silently-safe things; ask
   before anything destructive.

## What NOT to do

- Don't delete a user's content in `workspace/` or their `profile.md` as part of "healing."
- Don't rewrite working docs for style. Repair consistency, not taste.
- Don't add new dependencies or build steps. AI Desk stays zero-install.
