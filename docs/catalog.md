# Catalog — what's installed

The living list of every assistant and quick tool in AI Desk. **Keep this in sync** whenever one is
added, renamed, or removed (see `self-healing.md`). This is what `/catalog` reads.

> To see the raw definitions: assistants live in `../.claude/agents/`, tools in `../.claude/skills/`.

## Assistants (agents)

| Name                | What it does                                                                 |
| ------------------- | ---------------------------------------------------------------------------- |
| `email-assistant`   | Reads a message or brief and drafts replies/outbound emails in your voice.   |
| `meeting-notetaker` | Turns rough notes or a transcript into clean minutes, decisions, and action items with owners. |
| `research-analyst`  | Researches a topic/market/competitor on the web and returns a sourced brief. |
| `content-writer`    | Writes marketing & business content — newsletters, posts, one-pagers, SOPs — on-brand. |

## Quick tools (skills)

| Name             | What it does                                                                    |
| ---------------- | ------------------------------------------------------------------------------- |
| `weekly-planner` | Turns your goals + this week's commitments into a prioritized, realistic plan.  |
| `proofread`      | Polishes grammar, clarity, and tone of any text to match your profile voice.    |
| `summarize`      | Condenses long text/threads/docs into key points, decisions, and next actions.  |
| `inbox-triage`   | Sorts a batch of emails/messages into what needs a reply, an FYI, and can wait. |

## Commands (shortcuts)

| Type this    | Does                                              |
| ------------ | ------------------------------------------------- |
| `/setup`     | Run onboarding (same as typing `init`)            |
| `/help`      | Plain-language guide                              |
| `/catalog`   | Show this list                                    |
| `/profile`   | View or update your saved profile                 |
| `/new-agent` | Build a new assistant                             |
| `/new-skill` | Build a new quick tool                            |
| `/checkup`   | Health-check and auto-repair the repo             |

_When you build something new via `builder/build-guide.md`, add a row here as the final step._
