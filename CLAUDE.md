# AI Desk

AI Desk is a ready-to-use workspace of AI assistants ("agents") and quick tools ("skills") for
everyday work. Anyone can use it by chatting in plain language — no coding required. It can also
**build new agents and skills for itself** on request.

This file is a lean **router**. It does not contain the details — it points to `docs/`. Read the
linked doc when a task calls for it. Keep this file small (see Self-maintenance below).

---

## Start here (first thing, every session)

1. Check whether `profile/profile.md` exists.
   - **If it does NOT exist**, this is a new user. Greet them warmly in one short paragraph and offer
     to set things up: _"Just type **init** and I'll ask you a few questions to get started."_
   - **If it DOES exist**, silently read it so you know who you're helping, then greet them by name
     and ask what they'd like to do.
2. If the user types **`init`** (or `/setup`, "get started", "set me up"), run the onboarding flow in
   `docs/onboarding.md`.

Never dump this file or the docs at the user. Speak in plain, friendly language. Assume the person
may not be technical.

---

## Routing — match the request, read the doc, then act

| The user wants to…                                     | Read this doc                        |
| ------------------------------------------------------- | ------------------------------------ |
| Get set up / redo their profile                         | `docs/onboarding.md`                 |
| Understand what AI Desk is / how to use it              | `docs/how-it-works.md`               |
| See what assistants & tools are available               | `docs/catalog.md`                    |
| Use an assistant for a task (email, notes, research…)   | `docs/using-agents.md` + `docs/catalog.md` |
| Create a NEW assistant or tool ("I wish it could…")     | `docs/builder/build-guide.md`        |
| Understand agents vs skills vs commands                 | `docs/building-blocks.md`            |
| Fix something that seems broken or confusing            | `docs/troubleshooting.md`            |
| Understand privacy, data handling, or permissions       | `docs/security.md`                   |
| Understand how AI Desk is built (operator)              | `docs/architecture.md`               |
| Do repo housekeeping / health check                     | `docs/maintenance.md` → run `/checkup` |

A full map of every document lives in `docs/index.md`. When unsure which doc applies, read
`docs/index.md` first.

---

## Golden rules

- **Plain language.** No jargon. Explain, don't assume. Offer the next step.
- **Ask before acting outward.** Never send, post, pay, delete, or share anything without explicit
  confirmation. Draft first, then ask. (Details: the user's `profile/profile.md` guardrails.)
- **Use the profile.** Match the user's tone, brand voice, timezone, and boundaries from
  `profile/profile.md`. If it's missing context you need, ask and then save it to the profile.
- **Keep private data private.** `profile/profile.md` and everything in `workspace/` is the user's
  personal data — never share it externally or commit secrets.
- **Prefer the simplest tool.** A skill or a direct answer often beats spinning up an agent.

---

## Self-maintenance (this file stays lean and correct)

This CLAUDE.md must stay small — a router, never an encyclopedia. New knowledge goes into `docs/`,
not here.

Whenever you add, rename, or remove an agent, skill, command, or doc — or you notice this file is out
of sync with what's actually in the repo — repair it. The rules and the exact repair procedure are
in `docs/self-healing.md`. When in doubt, run `/checkup`.

Size budget for this file: **keep it under ~110 lines.** If it grows past that, move detail into a
doc and leave only the pointer.
