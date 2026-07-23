# Contributing to AI Desk

Thanks for helping improve AI Desk. This guide is for **operators and contributors** who maintain the
repo. End users never need it — they just chat with AI Desk.

> The most important rule: AI Desk can extend and repair itself. When you change it by hand, follow
> the same invariants the assistant does, so nothing drifts out of sync.

## Ground rules

1. **Zero-install stays zero-install.** No required dependencies, build step, or install. Any tooling
   you add (scripts, CI, editor config) must be optional and must not block end-user usage.
2. **`CLAUDE.md` is a lean router (≤110 lines).** New knowledge goes in `docs/`, not `CLAUDE.md`. At
   most, add a one-line pointer. See `docs/self-healing.md`.
3. **Plain language for users.** User-facing docs, agents, skills, and commands stay warm and
   jargon-free. Operator docs (`docs/architecture.md`, `docs/security.md`, this file) can be more
   technical.
4. **Safety model is non-negotiable.** Draft first; ask before any outward action (send/post/pay/
   delete/contact). See `docs/security.md`.

## How to add or change a capability

Prefer letting AI Desk build it (`/new-agent`, `/new-skill`, or just describe the need) — it follows
`docs/builder/build-guide.md`. To do it by hand:

- **Agent:** create `.claude/agents/<name>.md` with `name` + `description` frontmatter (optionally
  `tools`). Format: `docs/builder/build-guide.md`. Design: `docs/builder/agent-design.md`.
- **Skill:** create `.claude/skills/<name>/SKILL.md` with `name` + `description` frontmatter. Design:
  `docs/builder/skill-design.md`.
- **Command:** create `.claude/commands/<name>.md` with a `description` in frontmatter.
- **Doc:** create `docs/<name>.md` (lowercase-hyphenated).

Naming conventions are in `docs/architecture.md`.

## The self-healing checklist (run on every structural change)

Whenever you add, rename, or remove an agent, skill, command, or doc:

- [ ] `docs/index.md` lists every file in `docs/` (and nothing that no longer exists).
- [ ] `docs/catalog.md` matches `.claude/agents/`, `.claude/skills/`, and `.claude/commands/`.
- [ ] New/changed agents & skills have valid `name` + `description` frontmatter.
- [ ] `CLAUDE.md` is still ≤110 lines and all its links resolve.
- [ ] Ran `/checkup` (conversational) or `bash scripts/validate.sh` (deterministic) — both pass.

## Optional local checks

`scripts/validate.sh` verifies the invariants above without any dependencies (Bash + coreutils; uses
`python3` for JSON validation if present). CI runs it on pull requests
(`.github/workflows/validate.yml`). Neither is required to use AI Desk.

```bash
bash scripts/validate.sh
```

## Style

- Markdown, wrapped around ~100 columns to match existing files.
- Match the tone and structure of the doc you're editing; repair consistency, not taste.
- Keep changes surgical — touch only what the change requires.

## Commits & versioning

- Bump `VERSION` and add a `CHANGELOG.md` entry for material changes (architecture, the
  CLAUDE.md/docs contract, or the shipped set of agents/skills).
- Day-to-day capability additions by end users don't need a version bump — the catalog is the record.
