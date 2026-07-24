# Architecture (for operators)

How AI Desk is built and why. Users never need this — it's for whoever maintains or extends the repo.
For the plain-language version, see `how-it-works.md`.

## The design in one picture

```
AGENTS.md  ──routes to──▶  docs/            (the "second brain": all real instructions)
   │  (harness-agnostic       │
   │   source of truth)       ├─ builder/    how AI Desk creates new capabilities
   │                          └─ *.md        using / extending / maintaining
   │
   ├─ reads ▶  profile/profile.md            who the user is (private, git-ignored)
   ├─ uses  ▶  agents/*.md                    assistants (judgment + tools)
   ├─ uses  ▶  skills/*/SKILL.md              quick tools (fixed procedures)
   ├─ uses  ▶  commands/*.md                  shortcuts (init, help, checkup, …)
   └─ writes▶  workspace/                    drafts & outputs (private, git-ignored)
```

## Harness-agnostic by design

AI Desk runs in any AI coding tool (Claude Code, opencode, Cursor, Codex, Gemini CLI, GitHub Copilot,
…). There is **one** editable source — `AGENTS.md` plus the neutral `agents/`, `skills/`, `commands/`
folders — and no tool is privileged.

Each harness looks for capabilities in its own directory and file format, so a small generator
(`scripts/sync-harnesses.py`) projects the single source into each harness's native layout so
assistants/tools/commands **auto-register** there. Generated adapters are committed (end users run
nothing); contributors re-run the generator after editing a source file, and `validate.sh`/CI fail on
drift. Harnesses that read a different *entry* filename also get a **thin pointer** (`CLAUDE.md`,
`GEMINI.md`, `.github/copilot-instructions.md`, `.cursor/rules/`) that redirects to `AGENTS.md`.

Native registration is a convenience, not a dependency: because `AGENTS.md` teaches that capabilities
are plain files, a harness with no subagent/skill/command system still works by reading the source
file and following it. Full detail — the per-harness path table and how to add a tool — is in
`harnesses.md`.

## The core pattern: router + second brain

`AGENTS.md` is a **router**, not a manual. It carries only the start-here behavior, the harness-usage
convention, a routing table, the golden rules, and a self-maintenance pointer — and it must stay
under ~130 lines. Every real explanation lives in `docs/`. This keeps the always-loaded context tiny
while letting knowledge grow without limit in `docs/`, loaded on demand.

**The contract between `AGENTS.md` and `docs/`:**

1. `AGENTS.md` never inlines procedure — it points to a doc.
2. Every doc is listed in `docs/index.md` (the source of truth for what documentation exists).
3. Every installed agent, skill, and command is listed in `docs/catalog.md`.
4. When any of the above changes, the index/catalog are updated in the same pass (see
   `self-healing.md`).

These are the **self-healing invariants**. `checkup` verifies them conversationally; operators can
also run the deterministic `scripts/validate.sh`.

## Why zero-install

AI Desk is Markdown plus the `AGENTS.md` convention — no compiler, package manager, or runtime for
**end users**. A non-technical user can open the folder in their AI tool and work immediately, because
the per-harness adapters are committed. Contributor tooling (`scripts/sync-harnesses.py`, the
validation script, CI, an `.editorconfig`) uses only stock Python 3 / Bash, is run only when editing
the repo, and must never become a prerequisite for *using* the product. See `maintenance.md`
("No build step for end users").

## Directory contract

| Path                     | Role                                             | In git? |
| ------------------------ | ------------------------------------------------ | ------- |
| `AGENTS.md`              | The router / source of truth (≤130 lines)        | yes     |
| `agents/`                | Assistants — **source of truth (edit here)**     | yes     |
| `skills/`                | Quick tools — **source of truth (edit here)**    | yes     |
| `commands/`              | Command shortcuts — **source of truth (edit here)** | yes  |
| `scripts/sync-harnesses.py` | Generates the per-harness adapters from the source | yes |
| `.claude/`, `.opencode/`, `.cursor/`, `.gemini/`, `.codex/`, `.agents/`, `.github/prompts/` | **Generated** per-harness adapters + permission configs — do not edit | yes |
| `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`, `.cursor/rules/` | Thin per-harness entry pointers → `AGENTS.md` | yes |
| `docs/`                  | The second brain (all instructions)              | yes     |
| `docs/builder/`          | How AI Desk builds new agents/skills for itself  | yes     |
| `profile/profile.md`     | The user's saved profile                         | **no**  |
| `workspace/`             | The user's drafts and outputs                    | **no**  |

## Naming conventions

- **Agents:** `agents/<name>.md`, lowercase-hyphenated (`email-assistant`).
- **Skills:** `skills/<name>/SKILL.md`, lowercase-hyphenated (`inbox-triage`).
- **Commands:** `commands/<name>.md`; the user types the bare word (`init`, `help`) or `/<name>` if
  their harness exposes native slash-commands.
- **Docs:** lowercase-hyphenated `.md` under `docs/`; builder references under `docs/builder/`.

Full authoring guidance lives in `builder/agent-design.md` and `builder/skill-design.md`; contributor
workflow lives in the root `CONTRIBUTING.md`.

## Versioning

The repo carries a `VERSION` file (semantic version) and a `CHANGELOG.md`. Bump the version and add a
changelog entry when the architecture, the AGENTS.md/docs contract, or the shipped set of
agents/skills changes materially. Day-to-day capability additions by end users don't need a version
bump — the catalog is their record.
