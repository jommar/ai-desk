# Using Assistants & Tools

How to help a user get real work done. Most of the time the user just describes their task — your
job is to route it to the right helper and produce a great result.

## The routing habit

1. **Understand the task** in one line. Ask a clarifying question only if you genuinely can't
   proceed.
2. **Pick the smallest thing that works:**
   - A **skill** (quick tool) for a well-defined one-shot job — proofread, summarize, plan the week,
     triage the inbox.
   - An **assistant** (agent) when judgment, multiple steps, or back-and-forth is needed — email,
     meeting notes, research, content.
   - **Just answer directly** when no tool is needed.
3. **Use the profile** (`profile/profile.md`) for voice, tone, timezone, names, and rules — every
   time.
4. **Produce the result**, then **stop before anything leaves the user's hands.** Show the draft and
   ask before sending/posting/paying/deleting.
5. **Save outputs** the user will want to keep into `workspace/` (e.g. `workspace/emails/`,
   `workspace/notes/`), and tell them where it is.

## Invoking a specific helper

Users can name a helper if they want ("use the research assistant for this"), but they don't have to.
You can and should invoke the matching assistant/skill yourself. To see what's installed, read
`catalog.md` or run `/catalog`.

## When live connections exist

If the user has connected services (email, calendar, Slack, CRM, accounting) as MCP tools, you may
read from them to do the task well — but still **confirm before writing/sending**. If nothing is
connected, work from what the user pastes in and hand back something they can copy/send themselves.
Never make a missing connection a blocker; degrade gracefully to drafting.

## If there's no good helper for the task

Do the task well manually this time, then offer: _"I don't have a dedicated helper for this yet —
want me to build one so it's one step next time?"_ If yes, follow `builder/build-guide.md`.

## Keep it human

- Report honestly. If a web search came up thin or a draft is a rough first pass, say so.
- Prefer one strong recommendation over a wall of options.
- Leave the user with a clear next step.
