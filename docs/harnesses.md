# Harnesses — running AI Desk in any AI tool

AI Desk is **harness-agnostic**: it runs in any AI coding tool, not just one. This doc explains how,
which tools are supported natively, and how to add another.

> "Harness" = the AI coding tool you chat with (Claude Code, opencode, Cursor, Codex, Gemini CLI,
> GitHub Copilot, and others). AI Desk is the workspace; the harness is the app you open it in.

## Single source of truth, generated adapters

Everything you edit lives **once**, in tool-independent files:

| Source (edit these)        | What it is                                            |
| -------------------------- | ----------------------------------------------------- |
| `AGENTS.md`                | The instructions / router (the cross-tool standard)   |
| `agents/<name>.md`         | Assistants (Markdown + `name`, `description`, `tools`)|
| `skills/<name>/SKILL.md`   | Quick tools (Markdown + `name`, `description`)        |
| `commands/<name>.md`       | Shortcuts (Markdown + `description`; body `$ARGUMENTS`)|
| the posture in `scripts/sync-harnesses.py` | The shared permission/deny posture     |

Each harness looks for capabilities in its **own directory and file format**, so to make them
**auto-register natively** in every tool, a small generator projects the source into each harness's
layout:

```
python3 scripts/sync-harnesses.py          # regenerate all adapters
python3 scripts/sync-harnesses.py --check   # verify they match the source (CI runs this)
```

Generated files are **committed** to the repo, so end users clone and everything already works — they
never run the generator. Only a **contributor** runs it, after editing a source file. `scripts/validate.sh`
(and CI) fail if the generated files drift from the source. Generated files carry a
`GENERATED … DO NOT EDIT` marker — edit the source, not the copy.

## What each harness reads (and what AI Desk generates for it)

**Instruction file** — `AGENTS.md` is read natively by **opencode, Cursor, Codex, and Copilot**.
The two exceptions get a thin pointer that redirects to it: **Claude Code** via `CLAUDE.md` (imports
`@AGENTS.md`), **Gemini CLI** via `GEMINI.md` (imports `@./AGENTS.md`) plus a generated
`.gemini/settings.json` that adds `AGENTS.md` to its context files.

| Capability     | Claude Code        | opencode            | Cursor                  | Gemini CLI              | Codex                  | Copilot                       |
| -------------- | ------------------ | ------------------- | ----------------------- | ----------------------- | ---------------------- | ----------------------------- |
| **Assistants** | `.claude/agents/*.md` | `.opencode/agents/*.md` | via `.claude/agents/` compat | `.gemini/agents/*.md` | `.codex/agents/*.toml` | via `.claude/agents/` compat |
| **Quick tools**| `.claude/skills/`  | `.claude/`+`.agents/skills/` | `.agents/skills/`  | `.agents/skills/`       | `.agents/skills/`      | `.claude/skills/`             |
| **Commands**   | `.claude/commands/*.md` | `.opencode/commands/*.md` | `.cursor/commands/*.md` | `.gemini/commands/*.toml` | (use skills)      | `.github/prompts/*.prompt.md` |
| **Permissions**| `.claude/settings.json` | `.opencode/opencode.json` | `.cursor/permissions.json` | `.gemini/settings.json` | `.codex/config.toml` | VS Code settings              |

Notes:
- **Skills are the most portable**: `SKILL.md` is a shared standard. Generating into `.claude/skills/`
  and `.agents/skills/` covers all six tools (each dedupes by the skill's `name`).
- **Codex** has no committable project-level command dir (its prompts are user-level and deprecated),
  so command shortcuts reach Codex as **skills** or by typing the word — see the degrade rule below.
- The **permission posture** is defined once (deny credential stores, ask before shell) and rendered
  into each tool's own format. Cursor/Gemini/Codex use different models (terminal allowlist / sandbox),
  so their configs are safe-default approximations; the real guarantee — *draft first, never touch
  secrets* — lives in `AGENTS.md` and holds in every harness regardless of config.

## Graceful degradation

Native registration is a convenience, not a requirement. Because `AGENTS.md` teaches the model that
capabilities are plain files, **any** harness — even one with no subagent/skill/command system — still
works: the user asks in plain words and the model reads the matching `agents/`, `skills/`, or
`commands/` file and follows it.

## Adding support for another harness

1. If the tool reads `AGENTS.md`, its instructions already work. If it reads its own filename, add a
   **thin pointer** at that path that redirects to `AGENTS.md` (copy `CLAUDE.md` / `GEMINI.md`).
2. If the tool has native agent/skill/command dirs and you want auto-registration, add a target for it
   in `scripts/sync-harnesses.py` (a builder that emits its dir + format), then run the generator and
   add a column to the table above.
3. If the tool has a permission system, add a renderer for its config format from the shared posture.

Nothing here duplicates capability *content* — the generator always derives from the single source.
