# Docs Index — the AI Desk "second brain"

`CLAUDE.md` is deliberately tiny. Everything it needs to know how to behave lives here. This index is
the source of truth for **what documentation exists**. When you add or rename a doc, update this
list (see `self-healing.md`).

## For using AI Desk

| Doc                     | What it covers                                                          |
| ----------------------- | ----------------------------------------------------------------------- |
| `how-it-works.md`       | Plain-language overview of AI Desk for a non-technical person           |
| `onboarding.md`         | The full **`init`** flow — the questions to ask and how to build a profile |
| `using-agents.md`       | How to pick and use assistants and skills for real tasks                |
| `catalog.md`            | The living list of every assistant and skill currently installed        |
| `building-blocks.md`    | What agents, skills, and commands are — in plain language               |
| `glossary.md`           | Plain-language definitions of any term a user might not know            |
| `troubleshooting.md`    | Common problems and how to fix them                                     |

## For operators (running & securing AI Desk)

| Doc                | What it covers                                                              |
| ------------------ | --------------------------------------------------------------------------- |
| `architecture.md`  | How AI Desk is built: the router + second-brain design and the directory contract |
| `security.md`      | Security, privacy, data handling, and the permission posture                |

## For extending AI Desk (it builds itself)

| Doc                          | What it covers                                                     |
| ---------------------------- | ----------------------------------------------------------------- |
| `builder/build-guide.md`     | The step-by-step workflow to create a new agent or skill          |
| `builder/agent-design.md`    | How to design a good assistant (patterns, role/goal, autonomy)    |
| `builder/skill-design.md`    | How to design a good quick tool (procedure, triggers, edge cases) |
| `builder/tool-design.md`     | How to describe tools so an assistant uses them reliably          |
| `builder/memory-patterns.md` | When and how an assistant should remember things                  |
| `builder/evaluation.md`      | How to test a new assistant/skill and set success criteria        |

## For keeping AI Desk healthy

| Doc                | What it covers                                                              |
| ------------------ | --------------------------------------------------------------------------- |
| `self-healing.md`  | Rules that keep `CLAUDE.md` lean and the repo consistent, and how to repair |
| `maintenance.md`   | Routine housekeeping and what `/checkup` does                               |

## The profile

The user's answers from onboarding are saved to `../profile/profile.md` (git-ignored). The blank
schema is `../profile/profile.template.md`. Always read the profile before helping, and update it
when you learn something durable about the user.
