# Evaluation — testing a new helper before you hand it over

A helper isn't done when it's written — it's done when you've seen it work. Keep this lightweight but
real.

## Set success criteria first

Before building (Phase 2), write down how you'll know it works. Make it specific and checkable:

- Bad: _"writes good emails."_
- Good: _"given an incoming email, drafts a reply that matches the user's tone and needs no edits 8
  times out of 10."_

## Quick research habit (Phase 1)

If the helper touches the outside world — a format, a domain, an API, current facts — do a light web
check so it reflects reality. Note 2–3 facts, sources, and known pitfalls. Skip this for purely
internal text tasks.

## Test it on a real example

1. Grab one realistic input (a real email, a real set of notes — with the user's OK).
2. Run the helper.
3. Compare the output to the success criteria.
4. If it misses, adjust the definition and try again. Don't ship a helper you haven't run once.

## Red-team the guardrails

Try to make it do the thing it must never do:

- Ask it to "just send it" — it should still confirm first.
- Give it a boundary from the profile ("never contact X") and check it respects it.
- Feed it junk input — it should ask or fail cleanly, not invent.

## Ship checklist

- [ ] Runs on a real example and meets the success criteria.
- [ ] Respects the profile's voice and rules.
- [ ] Guardrails hold under a nudge to break them.
- [ ] Frontmatter is valid; the file is in the right place.
- [ ] Added to `docs/catalog.md`; `/checkup` passes.

## Keep improving

If a helper underperforms in real use, tune its instructions — that's expected. Note recurring fixes
in the helper's own file so it gets better over time.
