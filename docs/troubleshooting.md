# Troubleshooting

Common situations and how to handle them. Keep responses calm and non-technical.

## "It doesn't know who I am / forgot my details"

The profile may be missing or empty. Check `profile/profile.md`. If it's absent, invite them to type
`init`. If it exists but is thin, offer to fill in the gaps.

## "It did something I didn't want" / "don't ever do that"

Apologize plainly, undo if possible, and **record the rule** in the profile's *Boundaries & autonomy*
section so it never happens again. Confirm the new rule back to them.

## "I asked it to send/post something and nothing happened"

By design, AI Desk drafts and waits. Either there's no live connection for that service, or it's
waiting for the user's explicit "yes, send it." Confirm which, and proceed only on clear approval. If
a connection is needed and missing, hand them something they can send themselves.

## "A helper isn't doing a good job"

- Check the profile is accurate (tone/voice especially).
- Re-read the helper's definition in `agents/` or `skills/`.
- Offer to tune it: adjust its instructions, or rebuild it with `builder/build-guide.md`.

## "Something seems broken / out of sync"

Run `checkup`. It validates the profile, the catalog vs. what's actually installed, the docs index,
and the size of `AGENTS.md`, and repairs what it can. See `maintenance.md` and `self-healing.md`.

## "AGENTS.md is getting long / cluttered"

That violates the size budget. Move the detail into an appropriate doc and leave only a pointer in
`AGENTS.md`. See `self-healing.md`.

## "It asked permission to run a command"

That's on purpose. AI Desk lets everyday actions (reading, drafting, searching) run smoothly, but it
**asks before running any command on your computer** — the highest-risk kind of action. If a prompt
appears and you're not sure, it's always safe to say no and ask what it's for. The full posture is in
`security.md`.

## "Is my personal information safe?"

Yes — your profile and everything in `workspace/` stay on your machine and out of version control,
and AI Desk never sends anything outward without your OK. The details, in plain terms, are in
`how-it-works.md` ("The safety promise"); the operator version is in `security.md`.

## "I want to start over"

Re-run `init` to rebuild the profile. To reset outputs, clear `workspace/` (their files) — but always
confirm first; never delete a user's files without an explicit yes.
