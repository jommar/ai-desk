# Changelog

All notable changes to AI Desk are recorded here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Bump the version and add an entry for material changes (architecture, the `CLAUDE.md`/`docs` contract,
or the shipped set of agents/skills). Day-to-day capabilities that end users add are tracked in
`docs/catalog.md`, not here.

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
