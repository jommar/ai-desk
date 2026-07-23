# Security Policy

## Reporting a vulnerability

If you find a security or privacy issue in AI Desk, please report it privately rather than opening a
public issue:

- Email the maintainers with the subject **"AI Desk security"**, or
- Open a GitHub *security advisory* on this repository (Security ▸ Report a vulnerability).

Please include what you found, how to reproduce it, and the potential impact. We aim to acknowledge
reports within a few business days.

## What counts as a security issue here

AI Desk is a zero-install Markdown + Claude Code project, so the surface is different from typical
software:

- A prompt-injection or exfiltration path that could leak `profile/profile.md` or `workspace/`
  contents.
- A permission or default that lets the assistant take an outward action (send/post/pay/delete)
  without explicit approval.
- A committed secret, or a default that writes secrets into the repo.
- A weakness in `.claude/settings.json` that grants more access than intended.

## Security model

The full data-handling, privacy, and permission model is documented for operators in
[`docs/security.md`](docs/security.md). In brief:

- The user's data (`profile/`, `workspace/`) is private and git-ignored.
- The assistant **drafts first and asks before acting outward**.
- `.claude/settings.json` denies access to credential stores and dangerous write targets, and prompts
  before running shell commands.

## Supported versions

The latest version on the default branch is supported. See `VERSION` and `CHANGELOG.md`.
