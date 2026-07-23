# Onboarding — the `init` flow

This is the script you follow when a user types **`init`** (or asks to get set up). Your goal: build
a rich, useful `profile/profile.md` so every future interaction is personalized — while making the
person feel welcomed, not interrogated.

## Principles

- **Conversational, not a form.** Ask a few questions at a time, in plain language. React to answers.
- **Everything is optional.** If someone doesn't want to answer, skip it and move on. A partial
  profile is fine and can be filled in later.
- **Explain why briefly** when a question isn't obvious (e.g. "This helps me match your writing
  style.").
- **Adapt.** If they say "I run a bakery," don't ask generic questions you can already infer — ask
  bakery-relevant ones.
- **Confirm at the end.** Read back a short summary and let them correct it before you save.
- **Save to** `profile/profile.md` using the structure in `../profile/profile.template.md`. Create
  the file if it doesn't exist; update it if it does.

## Suggested flow (group the questions; don't fire all 40 at once)

Open with a warm one-liner: _"Great — I'll ask a handful of quick questions so I can help the way you
actually work. Answer what you like, skip anything you don't. Ready?"_

### 1. The basics

- What should I call you? (preferred name)
- Anything I should know about pronouns or how you'd like to be addressed? _(optional)_
- What's your timezone or city? (so scheduling and "this week" make sense)
- What language(s) should I work in?

### 2. Your work

- What do you do? (role / title)
- Tell me about your business or organization — name, what it does, who it serves.
- How big is it? (just you / small team / larger)
- What does a typical week look like — the recurring things you do?

### 3. Where AI Desk can help most

- What are the 2–3 things you'd most love help with?
- What eats up your time or drains you that you'd happily hand off?
- Are there tasks you avoid because they're tedious or you're unsure how to do them?

### 4. Your voice & style

- When you write to customers/colleagues, how do you sound? (e.g. warm, professional, direct,
  playful) Paste a sentence or two you've written if that's easier.
- Formal or casual? Long and thorough, or short and punchy?
- Emojis: love them, occasionally, or never?
- How do you sign off emails/messages?
- For business: any words or phrases you always use — or ones to never use?

### 5. The tools you use

- What do you use for email? (Gmail, Outlook/Microsoft 365, other)
- Calendar? Documents/notes? (Google, Microsoft, Notion, other)
- Do you use any of these: Slack/Teams, a CRM (e.g. HubSpot), accounting (e.g. QuickBooks), social
  platforms, project tools?
- _(Note which they have. If a matching connection/MCP is available you can act on real data; if
  not, you'll draft and they'll paste/send. Don't require any connection.)_

### 6. Boundaries & how much freedom to give me

- Are there things I should **never** do without asking? (send/pay/post/delete/contact specific
  people)
- Anything sensitive I should avoid, or topics/people that are off-limits?
- In general, do you prefer I **draft and wait for your OK** on everything, or **act on the small
  stuff** and check in on the big stuff? _(Default: draft and wait.)_

### 7. Key context (optional but powerful)

- Who are the important people I'll hear about? (top clients, teammates, your boss) — names + a word
  on each.
- Any current projects or goals I should keep in mind?
- Important recurring dates or deadlines?

### 8. What "good" looks like

- A month from now, how will you know AI Desk has been worth it?

## After the interview

1. Summarize what you heard in a short, friendly recap. Invite corrections.
2. Write/overwrite `profile/profile.md` following `../profile/profile.template.md`. Fill what you
   learned; leave clear `(not set)` placeholders for skipped items so they're easy to fill later.
3. Tell them what you can do right now, tailored to their answers, and suggest **one** concrete first
   task. Point them at `catalog` / `help` for the full picture.
4. If they mentioned a recurring need that no current assistant covers, offer to build one (see
   `builder/build-guide.md`).

## Re-running `init`

If `profile/profile.md` already exists, don't start from scratch. Say what you already have, and ask
only what's missing or what they'd like to change. Update the file and note the change.
