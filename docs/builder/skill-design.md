# Skill (Quick Tool) Design

Reference for designing a good quick tool. A skill does one well-defined job the same way every time.
Consult this during Phase 2–3 of `build-guide.md`.

## Name it well

- Lowercase-hyphenated. Verb-ish or clear noun: `proofread`, `weekly-planner`, `inbox-triage`.
- Don't name it after an API. Describe the job, not the plumbing.

## Skill vs assistant

Build a skill when the steps are known and fixed. The moment the procedure needs to *decide* what to
do next based on intermediate results, it's an assistant — see `agent-design.md`.

## The required parts

1. **Name** — unique, hyphenated.
2. **Description** — one sentence the model uses to decide when to run it. Include natural trigger
   words ("proofread", "clean up", "polish").
3. **Steps** — specific enough to follow without guessing.
4. **Output** — what it hands back, and where it saves it if it's a file (`workspace/…`).
5. **Edge cases** — what to do when input is missing, huge, or malformed.

## Write specific steps

Bad:

```
1. Process the text.
2. Return it.
```

Good:

```
1. Read the provided text (ask for it if none given).
2. Fix grammar, spelling, and clarity WITHOUT changing meaning.
3. Adjust tone to match profile voice (formality, warmth, emoji preference).
4. Return the polished text, then a 1-line note of what changed.
```

## Use the profile

Any skill that writes or edits text should match the user's voice from `profile/profile.md`
(formality, length, emoji, sign-off, never-use words). Say so explicitly in the steps.

## Composability

Design outputs so skills can chain: `summarize` → `weekly-planner`, `inbox-triage` →
`email-assistant`. Keep outputs clean and predictable.

## Anti-patterns

- **Vague steps** — "analyze it" instead of concrete actions.
- **Doing too much** — one skill that summarizes AND emails AND files. Split it.
- **Ignoring bad input** — assumes the happy path and breaks on surprises.
- **Should've been an assistant** — needs judgment mid-way → upgrade it.

## Where it lives

`skills/<name>/SKILL.md`, using the format in `build-guide.md`. Add supporting files in the same
folder if needed (templates, examples) and reference them from `SKILL.md`.
