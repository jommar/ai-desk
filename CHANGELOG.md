# Changelog

All notable changes to AI Desk are recorded here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Bump the version and add an entry for material changes (architecture, the `AGENTS.md`/`docs` contract,
or the shipped set of agents/skills). Day-to-day capabilities that end users add are tracked in
`docs/catalog.md`, not here.

## [2.0.0] - 2026-07-24

Harness-agnostic restructure — AI Desk now runs in any AI coding tool, not just Claude Code, from a
single source of truth with generated per-harness adapters.

### Added

- `AGENTS.md` — the single, harness-agnostic source of truth (the router formerly in `CLAUDE.md`),
  now also carrying the convention for using assistants/tools/commands in any harness.
- **`scripts/sync-harnesses.py`** — a stdlib-only generator that projects the one source into each
  harness's native directories and file formats (Claude Code, opencode, Cursor, Gemini CLI, OpenAI
  Codex, GitHub Copilot) plus their permission/settings configs, so assistants, quick tools, and
  commands **auto-register** in every tool. `--check` mode verifies the adapters match the source and
  is wired into `scripts/validate.sh` and CI (an 8th invariant).
- Thin per-harness entry pointers that redirect to `AGENTS.md` and hold no real content: `GEMINI.md`
  (imports `@./AGENTS.md`), `.github/copilot-instructions.md`, `.cursor/rules/ai-desk.mdc` (and
  `CLAUDE.md`, repurposed to import `@AGENTS.md`).
- `docs/harnesses.md` — the single-source/generated-adapter model, a per-harness path table, and how
  to add a tool; listed in `docs/index.md`.

### Changed

- **Editable source moved to neutral, tool-independent folders:** `.claude/agents/` → `agents/`,
  `.claude/skills/` → `skills/`, `.claude/commands/` → `commands/`. These are now the only place to
  edit a capability.
- **Per-harness dirs are now generated** from that source and committed:  `.claude/`, `.opencode/`,
  and the new `.cursor/`, `.gemini/`, `.codex/`, `.agents/`, `.github/prompts/`. The permission posture
  is defined once and rendered into each tool's config format. Generated files carry a DO-NOT-EDIT
  marker; end users still install nothing.
- `CLAUDE.md` is now a thin pointer to `AGENTS.md` (no longer the source of truth).
- `AGENTS.md` size budget is ~130 lines (was ~110 for `CLAUDE.md`); `scripts/validate.sh`, the CI
  workflow, and all docs updated to the new structure, paths, budget, and drift check.
- `docs/*`, `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, and the PR template de-Claude-ified:
  "Claude Code" generalized to "your AI tool / harness".

### Removed

- The hand-duplicated, hand-maintained `.opencode/agents/` and `.opencode/commands/` copies (they now
  regenerate from the single source) and stray opencode plugin `node_modules`/`package*.json`. This
  ends the per-harness duplication that was drifting.

## [1.0.0] - 2026-07-24

Enterprise-readiness hardening.

### Added

- `docs/security.md` — security, privacy, data-handling, and permission-posture reference for
  operators, including prompt-injection and exfiltration guidance.
- `docs/architecture.md` — operator architecture: the router + second-brain design, the
  `CLAUDE.md`/`docs` contract, directory contract, and naming conventions.
- Governance files: `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `CHANGELOG.md`, `VERSION`,
  `.editorconfig`.
- `scripts/validate.sh` — optional, dependency-light check of the self-healing invariants.
- `.github/workflows/validate.yml` — optional CI running the validation script on pull requests.
- `.github/pull_request_template.md` — reminds contributors to keep the index/catalog in sync.
- Profile & onboarding: team context, industry/regulatory context, and a *Compliance & data handling*
  section (all optional) for regulated and team environments.

### Changed

- `.claude/settings.json` — hardened permission posture: added a `deny` list for credential stores,
  shell startup files, global Claude config, and `.git/` internals; added a `$schema` reference.
  Everyday work (read/write/edit/search/fetch) still runs without prompts; `Bash` still asks first.
- `CLAUDE.md` — added routing rows for the new security and architecture docs (still a lean router).
- `docs/index.md` — added an operator-docs section listing `architecture.md` and `security.md`.

## [0.1.0] - 2026

### Added

- Initial scaffold: self-sustaining AI-agents workspace for non-technical users — lean `CLAUDE.md`
  router, `docs/` second brain, starter agents and skills, slash commands, onboarding/profile flow,
  and self-healing/maintenance docs.
