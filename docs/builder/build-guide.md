# Build Guide — how AI Desk makes new assistants & tools for itself

This is the workflow to follow when a user wants a new capability — whether they say _"build me
something that…"_, run `/new-agent` / `/new-skill`, or just describe a recurring need. It is adapted
from the agent-builder methodology and tuned for non-technical requesters. The big difference: the
finished helper is written **straight into `.claude/`** so it works immediately — no separate export
step.

## Golden rule: talk like a person, build like an engineer

The requester may not be technical. Ask plain questions. Do the rigorous design thinking yourself,
using the reference guides in this folder. Never make them learn the jargon.

## The five phases

```
0. FIGURE OUT WHAT THEY NEED → 1. QUICK RESEARCH → 2. SHORT INTERVIEW → 3. DESIGN CHECK → 4. BUILD IT
```

### Phase 0 — Figure out what they need

Decide **assistant (agent)** vs **quick tool (skill)** using `building-blocks.md` and
`agent-design.md`:

- Fixed steps, same every time → **skill**.
- Needs judgment / research / back-and-forth → **agent**.
- Unsure? Default to a **skill** (simpler); note it can be upgraded later.

Confirm in one friendly line: _"Sounds like a quick tool that does X — that right?"_

### Phase 1 — Quick research (only as much as the task needs)

For anything involving the outside world (a domain, a format, an API, best practices), do a light web
search so the helper reflects reality, not guesses. See `research-phase` habits in
`evaluation.md`. For a purely internal text task (e.g. "reformat my notes this way"), skip it.
Capture 2–3 useful facts, sources, and any failure modes to guard against.

### Phase 2 — Short interview

Ask only what you need. Reuse the profile — don't re-ask things you already know.

**For a skill** (see `skill-design.md`): name, what it does in one line, what it takes in, the exact
steps, what it returns, and what could go wrong.

**For an agent** (see `agent-design.md`): name, its role/expertise, its goal, the tools it needs,
how much freedom it has (autonomy), what it must never do (guardrails), and how you'll know it
worked.

Read back a short summary and get a thumbs-up before building.

### Phase 3 — Design check

Quietly cross-check the design against the reference guides:

- [ ] Right type (skill vs agent) for the task — `building-blocks.md`
- [ ] Clear, specific steps or operating protocol — `skill-design.md` / `agent-design.md`
- [ ] Tools are well described and minimal — `tool-design.md`
- [ ] Sensible memory choice — `memory-patterns.md`
- [ ] Guardrails cover anything risky (send/pay/post/delete) — inherit the profile's rules
- [ ] Testable success criteria — `evaluation.md`
- [ ] Simplicity — is there a smaller version that still delivers? If yes, build that.

Fix issues before building.

### Phase 4 — Build it (write into `.claude/`)

Create the file(s) using the exact formats below, then **register it**.

## Output formats (these must be valid Claude Code definitions)

### A new assistant → `.claude/agents/<name>.md`

```markdown
---
name: <lowercase-hyphenated-name>
description: <one sentence — what it does and WHEN to use it. This is how it gets picked.>
tools: <optional comma list, e.g. Read, Write, WebSearch — omit to inherit all>
---

You are <role — job title + specialization>. <backstory: experience, methodology, temperament>.

## Goal

<the single objective that drives its decisions>

## How you work

1. <step or operating rule>
2. <step or operating rule>

## Always use the user's profile

Read `profile/profile.md` for tone, voice, names, timezone, and rules. Match them.

## Never do

- <guardrail — e.g. send/post/pay without explicit approval>
- <guardrail>

## Done looks like

- <specific, checkable success criterion>
```

### A new quick tool → `.claude/skills/<name>/SKILL.md`

```markdown
---
name: <lowercase-hyphenated-name>
description: <one sentence the model uses to decide when to run this. Include trigger words.>
---

# <Skill Name>

## What it does

<one line>

## Steps

1. <specific step>
2. <specific step>
3. <specific step — reference profile voice where relevant>

## Edge cases

- <case>: <how to handle>

## Done looks like

- <checkable criterion>
```

## Register it (final step — don't skip)

1. Add a row to `docs/catalog.md` (Assistants or Quick tools table).
2. If it needs its own shortcut, add `.claude/commands/<name>.md`.
3. Run the self-heal check (`self-healing.md`) or `/checkup` so everything stays in sync.
4. Tell the user in plain language what you built and give them one example of how to use it.

## Keep it simple

Prefer the smallest helper that solves the real problem. Don't add options, tools, or steps nobody
asked for. A three-step skill that reliably works beats a clever agent that sometimes surprises.
