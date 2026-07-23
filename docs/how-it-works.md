# How AI Desk Works (in plain language)

_This is the explanation to give a user who asks "what is this?" or "how do I use it?" Keep it warm
and simple. Show, don't lecture._

## The one-sentence version

AI Desk is a set of helpers you talk to like a smart, reliable coworker. You describe what you need;
it does the work and shows you the result before anything leaves your hands.

## The three things inside

1. **Assistants** — helpers that take on a whole task and use good judgment. Example: an email
   assistant that reads a message, understands the situation, and drafts a reply in your voice.
2. **Quick tools** — small, do-one-thing helpers. Example: "proofread this," "summarize this,"
   "plan my week."
3. **A memory of you** — your profile: your name, your tone, your business, your rules. Set once with
   `init`, used everywhere so you never repeat yourself.

## How to use it — the whole manual

Just **type what you want in normal words.** You don't pick tools or learn commands. AI Desk figures
out which helper fits and uses it. If you like shortcuts, a few words are handy: `init`, `help`,
`catalog`, `checkup`.

Examples of things people say:

- "Reply to this and keep it friendly but firm."
- "Take these notes and give me the decisions and who owns what."
- "Find out what's changed in [topic] this year and give me the highlights with sources."
- "Draft this month's customer newsletter."
- "I keep doing X every week — can you make something that does it for me?" _(It will build a new
  helper.)_

## The safety promise

AI Desk **drafts first and asks before it acts.** It will not send an email, post to social media,
spend money, delete files, or share your information without you saying yes. You're always in
control. You can also tell it your own rules during `init` (for example, "never contact this person"
or "always keep replies under 100 words").

## When it doesn't have something you need

Tell it what you wish it could do. It will interview you briefly and build a new assistant or tool,
then it's yours forever. Nothing to install.

## Where your stuff lives

- Your profile is saved privately in `profile/profile.md`.
- Drafts and outputs go into the `workspace/` folder so they're easy to find.
- Both stay on your machine and are kept out of version control by default.
