# Architecture (for operators)

How AI Desk is built and why. Users never need this — it's for whoever maintains or extends the repo.
For the plain-language version, see `how-it-works.md`.

## The design in one picture

```
CLAUDE.md  ──routes to──▶  docs/            (the "second brain": all real instructions)
   │                          │
   │                          ├─ builder/    how AI Desk creates new capabilities
   │                          └─ *.md        using / extending / maintaining
   │
   ├─ reads ▶  profile/profile.md            who the user is (private, git-ignored)
   ├─ runs  ▶  .claude/agents/*.md           assistants (judgment + tools)
   ├─ runs  ▶  .claude/skills/*/SKILL.md     quick tools (fixed procedures)
   ├─ runs  ▶  .claude/commands/*.md         shortcuts (init, help, checkup, …)
   └─ writes▶  workspace/                    drafts & outputs (private, git-ignored)
```

## The core pattern: router + second brain

`CLAUDE.md` is a **router**, not a manual. It carries only the start-here behavior, a routing table,
the golden rules, and a self-maintenance pointer — and it must stay under ~110 lines. Every real
explanation lives in `docs/`. This keeps the always-loaded context tiny while letting knowledge grow
without limit in `docs/`, loaded on demand.

**The contract between `CLAUDE.md` and `docs/`:**

1. `CLAUDE.md` never inlines procedure — it points to a doc.
2. Every doc is listed in `docs/index.md` (the source of truth for what documentation exists).
3. Every installed agent, skill, and command is listed in `docs/catalog.md`.
4. When any of the above changes, the index/catalog are updated in the same pass (see
   `self-healing.md`).

These are the **self-healing invariants**. `/checkup` verifies them conversationally; operators can
also run the deterministic `scripts/validate.sh`.

## Why zero-install

AI Desk is Markdown plus Claude Code conventions — no compiler, package manager, or runtime. A
non-technical user can open the folder and work immediately. Any tooling an operator adds (the
validation script, CI, an `.editorconfig`) is **optional** and must never become a prerequisite for
using the product. See `maintenance.md` ("Deliberately no build step").

## Directory contract

| Path                   | Role                                             | In git? |
| ---------------------- | ------------------------------------------------ | ------- |
| `CLAUDE.md`            | The router (≤110 lines)                          | yes     |
| `docs/`                | The second brain (all instructions)              | yes     |
| `docs/builder/`        | How AI Desk builds new agents/skills for itself  | yes     |
| `.claude/agents/`      | Assistants                                       | yes     |
| `.claude/skills/`      | Quick tools                                      | yes     |
| `.claude/commands/`    | Slash-command shortcuts                          | yes     |
| `.claude/settings.json`| Permission posture (see `security.md`)           | yes     |
| `profile/profile.md`   | The user's saved profile                         | **no**  |
| `workspace/`           | The user's drafts and outputs                    | **no**  |

## Naming conventions

- **Agents:** `.claude/agents/<name>.md`, lowercase-hyphenated (`email-assistant`).
- **Skills:** `.claude/skills/<name>/SKILL.md`, lowercase-hyphenated (`inbox-triage`).
- **Commands:** `.claude/commands/<name>.md`; the user types `/<name>` (or the bare word for the
  common ones like `init`, `help`).
- **Docs:** lowercase-hyphenated `.md` under `docs/`; builder references under `docs/builder/`.

Full authoring guidance lives in `builder/agent-design.md` and `builder/skill-design.md`; contributor
workflow lives in the root `CONTRIBUTING.md`.

## Versioning

The repo carries a `VERSION` file (semantic version) and a `CHANGELOG.md`. Bump the version and add a
changelog entry when the architecture, the CLAUDE.md/docs contract, or the shipped set of
agents/skills changes materially. Day-to-day capability additions by end users don't need a version
bump — the catalog is their record.
