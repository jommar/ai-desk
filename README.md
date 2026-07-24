# AI Desk 🖥️

**Your own desk of AI assistants — for real work, no coding required. Runs in any AI tool.**

AI Desk is a folder you open in your AI coding tool and simply _talk to_. It comes with ready-made
assistants (draft emails, turn messy notes into clean minutes, research a topic, write content) and
quick tools (plan your week, proofread, summarize, triage your inbox). It learns about you once, then
helps in your voice. And when you wish it could do something new, it can **build a new assistant for
itself** — you just describe what you want.

**Harness-agnostic:** because everything here is plain Markdown, AI Desk works the same in
[Claude Code](https://claude.com/claude-code), [opencode](https://opencode.ai), Cursor, OpenAI Codex,
Gemini CLI, GitHub Copilot, and others. There's one source of truth (`AGENTS.md`) and no build step.
See [`docs/harnesses.md`](docs/harnesses.md).

---

## For everyday use (just chat)

You don't need to know anything technical. Open this folder in your AI tool and:

1. **Type `init`** the first time. It asks a few friendly questions and remembers your answers.
2. **Ask for what you need**, in plain words. For example:
   - _"Draft a polite reply to this email…"_
   - _"Turn these meeting notes into action items."_
   - _"Research our top 3 competitors and summarize."_
   - _"Plan my week around these priorities."_
   - _"I wish I had something that writes my weekly customer update."_ → it will build one.
3. **Type `help`** any time to see what it can do.

That's it. It will always show you a draft and ask before sending, posting, or paying for anything.

**Handy things to type:**

| Type this   | What happens                                            |
| ----------- | ------------------------------------------------------- |
| `init`      | Set up (or update) your profile                         |
| `help`      | Plain-language guide to everything                      |
| `catalog`   | List the assistants and tools you have                  |
| `checkup`   | Make sure everything is healthy and up to date          |

> Some tools expose these as native slash-commands (`/help`); in any tool you can just type the plain
> word. If your tool doesn't pick up the intent, ask in normal words — it always works.

---

## Which AI tools does it work in?

Any of them. `AGENTS.md` is the single source of truth and the standard file most tools read. Tools
that read a different filename get a tiny pointer that redirects to it:

| Tool           | Just works via        | Tool               | Just works via                     |
| -------------- | --------------------- | ------------------ | ---------------------------------- |
| opencode       | `AGENTS.md` (native)  | Claude Code        | `CLAUDE.md` → `AGENTS.md`          |
| OpenAI Codex   | `AGENTS.md` (native)  | Gemini CLI         | `GEMINI.md` → `AGENTS.md`          |
| Cursor         | `AGENTS.md` (native)  | GitHub Copilot     | `.github/copilot-instructions.md`  |

Adding another tool is usually zero work (it reads `AGENTS.md`) or one small pointer file — see
[`docs/harnesses.md`](docs/harnesses.md).

---

## For the person who set this up (operator)

This repo is self-contained. **End users install nothing** — the per-harness adapters are committed,
so it works on clone. The editable source is Markdown; a small generator projects it into each tool.

- **`AGENTS.md`** — the harness-agnostic *source of truth*: a lean *router* that stays small and
  points to `docs/`.
- **`agents/`, `skills/`, `commands/`** — the editable **source** for assistants, quick tools, and
  shortcuts. Edit these.
- **`scripts/sync-harnesses.py`** — regenerates each harness's native dirs from that source
  (contributor-only; `python3 scripts/sync-harnesses.py`). Run it after editing a source file.
- **`.claude/`, `.opencode/`, `.cursor/`, `.gemini/`, `.codex/`, `.agents/`, `.github/prompts/`** —
  **generated** adapters + permission configs so capabilities auto-register natively. Don't edit these.
- **`CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`, `.cursor/rules/`** — thin per-harness
  entry pointers that redirect to `AGENTS.md`. They hold no real content, so nothing drifts.
- **`docs/`** — the "second brain." All real instructions live here so `AGENTS.md` never bloats.
  Start at `docs/index.md`.
- **`profile/`** — the user's saved profile (created by `init`). `profile.md` is git-ignored.
- **`workspace/`** — where drafts and outputs land. Git-ignored by default (private).

### Self-sustaining by design

- **Self-healing docs:** the assistant keeps `AGENTS.md` lean and the catalog/index in sync. See
  `docs/self-healing.md`. Run `checkup` any time to validate and auto-repair.
- **Self-extending:** it can generate new agents/skills for itself via `docs/builder/build-guide.md`
  (adapted from the agent-builder methodology). New capabilities are written into `agents/`, `skills/`,
  or `commands/`, then one `sync-harnesses.py` run makes them auto-register in every harness.
- **No build step for end users:** no `npm install`, no dependencies to *use* it. The contributor-only
  generator (`sync-harnesses.py`) uses stock Python 3 — no `pip install` — and CI checks the adapters
  stay in sync with the source.

### Security & privacy

- The user's data (`profile/profile.md`, everything in `workspace/`) is private and git-ignored.
- The assistant **drafts first and asks before acting outward** (send/post/pay/delete/contact). This
  rule lives in the instructions, so it holds in every harness.
- Harnesses with a permission system also enforce a least-privilege posture. The posture is defined
  once and generated into each tool's config (`.claude/settings.json`, `.opencode/opencode.json`,
  `.cursor/permissions.json`, `.gemini/settings.json`, `.codex/config.toml`): deny access to
  credential stores and dangerous write targets, and ask before running shell commands.
- Full data-handling & permission model: [`docs/security.md`](docs/security.md) and
  [`SECURITY.md`](SECURITY.md).

### Governance & maintenance

- Contributor workflow and conventions: [`CONTRIBUTING.md`](CONTRIBUTING.md). Architecture:
  [`docs/architecture.md`](docs/architecture.md). Version history: [`CHANGELOG.md`](CHANGELOG.md) /
  [`VERSION`](VERSION).
- Optional, dependency-light health check (mirrors `checkup`): `bash scripts/validate.sh`. It also
  runs in CI on pull requests. Neither is required to use AI Desk.

### Requirements

- Any AI coding tool that reads a project instruction file (`AGENTS.md` or a supported equivalent).
  Open this folder as the working directory.
- Optional: connect services (Gmail/Microsoft 365, Slack, calendar, CRM, etc.) as MCP servers to let
  assistants act on real data. AI Desk works fine without them — it just drafts instead of sends.

---

## How it fits together

```
You  ⇄  Your AI tool (reads AGENTS.md, or a pointer → AGENTS.md)
             │
             ├─ profile/profile.md      ← who you are, your voice, your rules
             ├─ docs/                    ← how everything works (the "second brain")
             ├─ agents/                  ← your assistants
             ├─ skills/                  ← your quick tools
             ├─ commands/                ← your shortcuts
             └─ workspace/               ← your drafts & outputs
```

Everything else — how onboarding works, how to add capabilities, how it heals itself, which tools it
runs in — is documented in `docs/`. Begin at [`docs/index.md`](docs/index.md).
