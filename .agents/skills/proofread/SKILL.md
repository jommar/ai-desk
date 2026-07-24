---
name: proofread
description: Polishes grammar, spelling, clarity, and tone of any text to match the user's voice, without changing its meaning. Trigger on "proofread", "clean this up", "polish", "check my writing", "fix the grammar".
---

# Proofread

## What it does

Fixes and tightens a piece of text while keeping the user's meaning and voice intact.

## Steps

1. Read `profile/profile.md` for voice: formality, length preference, emoji, always/never words.
2. Read the text the user provides (ask for it if none was given).
3. Correct grammar, spelling, and punctuation. Improve clarity and flow. Remove padding.
4. Adjust tone to match the profile voice — but do **not** change the intended meaning or add new
   claims.
5. Return the polished text, then a short bullet list of the notable changes (so the user can trust
   what you did).

## Edge cases

- Text is already clean: say so and make only light touch-ups.
- User wants a specific tone different from their default (e.g. "make this more formal"): follow the
  request over the profile default, and note that you did.
- Very long text: process it fully; if it's enormous, confirm scope first.

## Done looks like

- Cleaner, clearer text in the user's voice, with meaning unchanged and changes summarized.
