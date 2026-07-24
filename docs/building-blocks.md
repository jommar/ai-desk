# Building Blocks (plain language)

AI Desk is made of three simple kinds of things. You never *have* to know this to use it — but it
helps when you want to add something.

## Assistant (a.k.a. "agent")

A helper that takes on a whole task and uses judgment. It can think through steps, look things up,
and go back and forth with you. Good when the work isn't a fixed recipe.

> _"Handle this customer complaint email"_ — it reads, weighs tone, drafts, and adjusts.

Lives in `agents/<name>.md`.

## Quick tool (a.k.a. "skill")

A small helper that does one well-defined job the same way each time. Fast and predictable.

> _"Proofread this."_ — same reliable procedure every time.

Lives in `skills/<name>/SKILL.md`.

## Command (a shortcut)

A word you type to trigger something instantly, like `init`, `help`, or `checkup`. Just a
convenience layer over the above.

Lives in `commands/<name>.md`.

## Which do I make?

| If the task…                                        | Make a…      |
| --------------------------------------------------- | ------------ |
| Follows the same fixed steps every time             | Quick tool   |
| Needs judgment, research, or a conversation         | Assistant    |
| Is just a handy shortcut to start one of the above  | Command      |

When in doubt, start with a quick tool — it's simpler. You can always upgrade it to an assistant
later. The builder (`builder/build-guide.md`) walks you through the choice.
