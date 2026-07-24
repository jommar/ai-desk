---
name: summarize
description: Condenses long text, threads, transcripts, or documents into key points, decisions, and next actions. Trigger on "summarize", "TL;DR", "give me the gist", "what are the key points", "condense this".
---

# Summarize

## What it does

Turns something long into a short, faithful summary the user can act on.

## Steps

1. Read the text the user provides (ask for it, or accept a file path in `workspace/`).
2. Identify the purpose: are they after the gist, the decisions, the action items, or all three? If
   unclear, produce all three briefly.
3. Return:
   - **Gist** — 2–4 sentences.
   - **Key points** — a short bulleted list.
   - **Decisions / action items** — if any are present (task · owner if known).
4. Stay faithful — summarize what's there; don't add opinions or invent conclusions. Note if the
   source is ambiguous or contradictory.
5. Match the length to the source: a short thread gets a few lines, a long document gets a tight
   half-page — never a wall of text.

## Edge cases

- Multiple documents/threads: summarize each briefly, then give one combined takeaway.
- Source is already short: just give the one-line gist.
- Contains sensitive info: keep it in the summary only as needed; never send it anywhere.

## Done looks like

- A faithful, skimmable summary sized to the source, with actions surfaced if present.
