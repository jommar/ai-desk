# Agent (Assistant) Design

Reference for designing a good assistant. An assistant uses judgment and tools in a loop to finish a
task. Consult this during Phase 2–3 of `build-guide.md`.

## Name it well

- Lowercase-hyphenated, 2–4 words, descriptive over clever: `email-assistant`, `research-analyst`.
- Say what it does at a glance. Avoid naming it after a tool or a vague label like `helper`.

## Is an assistant even the right call?

Start with the smallest thing. Use a **skill** (fixed steps) or a direct answer unless the task truly
needs:

- multiple steps whose number you can't predict,
- decisions made along the way based on what it finds,
- or genuine back-and-forth.

If not, build a skill (`skill-design.md`).

## The triad every assistant needs

- **Role** — job title + specialization. _"A meticulous executive assistant who lives in email all
  day,"_ not _"a helper."_
- **Goal** — the one objective that drives every decision. _"Draft replies that sound exactly like
  the user and move the conversation forward,"_ not _"help with email."_
- **Backstory / method** — how it thinks and what it's careful about. This is where judgment comes
  from.

## Pick one architecture pattern

Most AI Desk assistants are one of these — choose the dominant one:

| Pattern                 | Use when…                                                          |
| ----------------------- | ------------------------------------------------------------------ |
| **Prompt chaining**     | The job is a clean sequence: outline → draft → polish.             |
| **Routing**             | Inputs fall into distinct buckets handled differently.             |
| **Evaluator-optimizer** | Quality matters and it can critique then improve its own draft.    |
| **Autonomous loop**     | Open-ended; number of steps and strategy aren't knowable upfront.  |

(Parallelization and orchestrator-workers exist for heavier multi-part jobs — rarely needed here.)

## Autonomy — how much freedom

Default to the cautious end and earn trust:

| Level             | Meaning                                          |
| ----------------- | ------------------------------------------------ |
| **Draft & wait**  | Produces work, asks before anything leaves. _(Default for AI Desk.)_ |
| **Check-in**      | Acts on small things, pauses at big decisions.   |
| **Autonomous**    | Runs end-to-end. Only for low-risk, proven jobs. |

Whatever the level, inherit the user's guardrails from `profile/profile.md`.

## Tools — give it few, well-described

More tools = more mistakes. Give the minimum. Describe each per `tool-design.md`. Omit the optional
`tools:` field to inherit everything the harness offers, or list a focused set for a tighter, safer
assistant (harnesses that support per-agent tool scoping will honor it; others simply ignore it).

## Guardrails (always)

- Never send, post, pay, delete, or contact people without explicit approval — unless the profile
  clearly says otherwise.
- Validate what it's given; if inputs are missing, ask rather than guess.
- Say when it's unsure or a result is thin. No silent failures.

## Anti-patterns to avoid

- **Over-engineering** — an autonomous loop where three fixed steps would do.
- **Vague role/goal** — the assistant can't make good calls without a sharp identity.
- **Tool overload** — 10 tools "just in case."
- **No stopping condition** — it doesn't know when it's done.

## Success criteria

Write down how you'd check it works (see `evaluation.md`). "Drafts a reply that matches the user's
last 3 emails in tone and needs no edits" beats "writes good emails."
