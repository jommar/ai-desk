# AI Desk 🖥️

**Your own desk of AI assistants — for real work, no coding required.**

AI Desk is a folder you open in [Claude Code](https://claude.com/claude-code) and simply _talk to_.
It comes with ready-made assistants (draft emails, turn messy notes into clean minutes, research a
topic, write content) and quick tools (plan your week, proofread, summarize, triage your inbox). It
learns about you once, then helps in your voice. And when you wish it could do something new, it can
**build a new assistant for itself** — you just describe what you want.

---

## For everyday use (just chat)

You don't need to know anything technical. Open this folder in Claude Code and:

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

---

## For the person who set this up (operator)

This repo is a self-contained Claude Code project. Nothing to install or build — it's Markdown +
Claude Code conventions.

- **`CLAUDE.md`** — a lean *router*. It stays small on purpose and points to `docs/`.
- **`docs/`** — the "second brain." All real instructions live here so `CLAUDE.md` never bloats.
  Start at `docs/index.md`.
- **`profile/`** — the user's saved profile (created by `init`). `profile.md` is git-ignored.
- **`.claude/agents/`** — the assistants (Claude Code subagents).
- **`.claude/skills/`** — the quick tools (Claude Code skills).
- **`.claude/commands/`** — the slash commands (`/setup`, `/help`, `/new-agent`, `/checkup`, …).
- **`workspace/`** — where drafts and outputs land. Git-ignored by default (private).

### Self-sustaining by design

- **Self-healing docs:** the assistant keeps `CLAUDE.md` lean and the catalog/index in sync. See
  `docs/self-healing.md`. Run `/checkup` any time to validate and auto-repair.
- **Self-extending:** it can generate new agents/skills for itself via `docs/builder/build-guide.md`
  (adapted from the agent-builder methodology). New capabilities are written straight into
  `.claude/` so they work immediately.
- **Zero build step:** no `npm install`, no dependencies required to use it.

### Requirements

- Claude Code installed and signed in. Open this folder as the working directory.
- Optional: connect services (Gmail/Microsoft 365, Slack, calendar, CRM, etc.) as MCP servers to let
  assistants act on real data. AI Desk works fine without them — it just drafts instead of sends.

---

## How it fits together

```
You  ⇄  Claude Code (reads CLAUDE.md)
             │
             ├─ profile/profile.md      ← who you are, your voice, your rules
             ├─ docs/                    ← how everything works (the "second brain")
             ├─ .claude/agents/          ← your assistants
             ├─ .claude/skills/          ← your quick tools
             └─ workspace/               ← your drafts & outputs
```

Everything else — how onboarding works, how to add capabilities, how it heals itself — is documented
in `docs/`. Begin at [`docs/index.md`](docs/index.md).
