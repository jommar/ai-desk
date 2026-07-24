# Memory Patterns

How much should a new assistant or skill *remember*? Pick the lightest option that does the job.

## The tiers

| Tier         | What it means                                          | Use when…                                   |
| ------------ | ------------------------------------------------------ | ------------------------------------------- |
| **None**     | Works only from what it's given right now.             | One-shot tasks: proofread, summarize.       |
| **Session**  | Remembers the current conversation.                    | Multi-turn tasks within one sitting.        |
| **Profile**  | Reads/writes `profile/profile.md` for durable facts.   | Anything that should persist about the user.|
| **Workspace**| Reads/writes files in `workspace/`.                    | Ongoing work with saved artifacts.          |

Most AI Desk helpers need only **None** or **Profile**. Reach higher only when the task truly spans
time.

## The profile is the shared memory

AI Desk's long-term memory is `profile/profile.md`. Prefer it over inventing new storage:

- **Read it** at the start of any personalized task (voice, names, rules, timezone).
- **Write to it** when you learn something durable — a new client, a changed preference, a new rule.
  Note what changed.
- Keep entries short and factual. It's a profile, not a diary.

## Workspace for artifacts

When a helper produces something the user keeps (a draft, a report, a plan), save it under
`workspace/` in a sensible subfolder and tell the user the path. That *is* the memory of the work —
no database needed.

## The memory-keeper agent

AI Desk ships with a `memory-keeper` agent (`../agents/memory-keeper.md`) that implements this
pattern. It manages two stores — `workspace/session-memory.md` for the current session and
`workspace/long-term-memory.md` for durable knowledge — and captures context autonomously, not just
on explicit "remember" commands. When building a new assistant, prefer delegating memory tasks to it
rather than rolling your own.

## Don't over-remember

- Don't stash secrets or sensitive data beyond what the task needs.
- Don't duplicate what's already in the profile.
- Don't build custom state files when the profile or workspace already covers it.
