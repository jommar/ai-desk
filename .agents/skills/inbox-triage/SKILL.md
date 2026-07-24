---
name: inbox-triage
description: Sorts a batch of emails or messages into what needs a reply, what's just an FYI, and what can wait — with a suggested action for each. Trigger on "triage my inbox", "sort these emails", "what should I reply to", "go through my messages".
---

# Inbox Triage

## What it does

Takes a pile of emails/messages and turns it into an ordered, decision-ready list so the user knows
exactly what to do and in what order.

## Steps

1. Read `profile/profile.md` for who the important people are and any off-limits contacts.
2. Take the messages — pasted in, or read from a connected email account if one is available.
3. Sort each into one of:
   - **Reply now** — needs a response today (why + suggested one-line action).
   - **FYI / no action** — read and move on.
   - **Can wait / delegate** — note when to revisit or who to hand it to.
4. Within "Reply now," order by urgency and importance (VIP senders from the profile rank up).
5. Return a clean list grouped by the three buckets. For each "Reply now" item, offer to draft the
   reply via `email-assistant`.

## Edge cases

- Huge batch: summarize counts per bucket first, then detail the "Reply now" items.
- Spam/newsletters: group them as "Can wait" and note they look low-priority; don't delete anything.
- No connection: work from what the user pastes; never claim to have read an inbox you can't access.

## Done looks like

- Every message is bucketed, "Reply now" is ordered, and the user has a clear first action.
