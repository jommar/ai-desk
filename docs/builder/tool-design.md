# Tool Design

When an assistant uses tools (built-in ones, or a connected service via MCP), how well it works
depends on how clearly each tool is described. Consult this when listing tools in Phase 2–3.

## The one idea

An assistant only uses a tool well if it understands **what it does, when to reach for it, what to
pass, and what it gets back.** Ambiguity here is the #1 cause of an assistant misbehaving.

## Describe each tool with

- **Purpose** — what it does, in one line.
- **When to use it** — and when NOT to. This prevents wrong-tool errors.
- **Inputs** — each parameter, its type, and an example.
- **Output** — the shape of what comes back.
- **Failure modes** — what happens on bad input, no results, timeouts, or missing permissions — and
  what the assistant should do then.

## Fewer is better

Every extra tool competes for the assistant's attention and adds a way to go wrong. Give the minimum
set that covers the job. If a job needs many tools, prefer discovery (let the assistant search for
the right one) over dumping them all in.

## Connected services (MCP)

If the assistant acts on a real service (email, calendar, Slack, CRM, accounting):

- **Read freely, write carefully.** Reading to inform a draft is fine; sending/creating/deleting
  needs explicit user approval per the profile guardrails.
- **Never hardcode secrets.** Credentials live in the connection/MCP config, not in the assistant
  file.
- **Degrade gracefully.** If the service is missing or errors, fall back to producing something the
  user can do by hand — don't dead-end.
- **Respect limits.** On rate limits or outages, back off and tell the user clearly rather than
  failing silently.

## Good vs bad description

Bad: _"email tool — sends emails."_

Good: _"`send_email` — sends an email via the connected account. Use only after the user has
approved the exact draft. Inputs: `to` (address), `subject`, `body` (plain text or HTML). Returns a
message id on success. If the account isn't connected, do NOT call it — hand the user the draft to
send themselves."_
