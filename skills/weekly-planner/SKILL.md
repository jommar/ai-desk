---
name: weekly-planner
description: Turns the user's goals and this week's commitments into a realistic, prioritized weekly plan. Trigger on "plan my week", "weekly plan", "help me organize this week", "what should I focus on".
---

# Weekly Planner

## What it does

Takes the user's priorities plus whatever they already have on this week (meetings, deadlines,
recurring tasks) and produces a focused, achievable plan for the week.

## Steps

1. Read `profile/profile.md` for the user's role, timezone, and recurring commitments.
2. Ask (or accept from the message) two things: the top goals for the week, and any fixed
   commitments/deadlines. Pull from a connected calendar if one is available; otherwise use what the
   user gives you.
3. Identify the 3 most important outcomes for the week — call these the "big rocks."
4. Lay out a day-by-day plan (respecting the timezone): assign the big rocks to focused blocks first,
   then fit smaller tasks around fixed commitments. Don't overfill — leave buffer.
5. Return:
   - **Top 3 outcomes** for the week.
   - **Day-by-day plan** (simple list per day).
   - **If everything slips, do these** — the 1–2 things that matter most.
6. Offer to save it to `workspace/plans/` with the week's date.

## Edge cases

- No goals given: ask for them, or infer 2–3 from the profile's priorities and confirm.
- Overloaded week: say so plainly and suggest what to cut or defer, don't pretend it all fits.
- No calendar/connection: work entirely from what the user pastes in.

## Done looks like

- Three clear priorities, a plan that fits real hours, and a fallback if the week goes sideways.
