---
name: sol-loop
description: Use when the user says "sol loop".
---

# sol-loop

Have an outside model review your change in rounds. Fix what it finds with
the smallest change, and push back on scope creep.

## Reviewer

1. Codex, unless `~/.claude/skills/sol-loop/codex-limits.sh` prints
   `BLOCKED` or Codex hits a usage limit.
2. Then Grok.
3. If both are out, a Claude model stronger than the one that wrote most of
   the change: Fable for Opus, Opus for Sonnet or Haiku. If Fable wrote it,
   wait until Codex or Grok has usage again.

Once a loop moves to a fallback, it stays there. In T3, run each round with
`delegate_task`. Elsewhere, use the commands in `~/.claude/CLAUDE.md`, or
`claude -p --model <fable|opus> --permission-mode plan` for Claude. A
timeout, error or empty reply is not approval.

## Rounds

Review the diff from `git merge-base HEAD origin/<base>` to the working
tree, the same diff every round. Run the checks first. The repo's
`AGENTS.md` sets the round limit, or else 3.

Round 1 brief:

```
Review only. Do not edit, commit, push, comment on PRs, or start subagents.
Repo: <abs path> Base: <sha> Intent: <intent> Out of scope: <scope> Checks: <results>
<repo review guidelines from AGENTS.md>
See: git diff <base> [-- <paths>]; git status --short (read untracked).
Find bugs, broken callers, mismatch with intent. Flag code the intent doesn't need.
blocker = intended case wrong. should = real bug callers will hit. nit = the rest.
Reply:
VERDICT: APPROVE or CHANGES
S1 [blocker|should|nit] <file>:<line> <claim>. Fix: <suggestion> (stable ids)
```

Later rounds send the same brief, the list of findings so far, and what
changed. For each finding, agree and make the smallest fix, disagree with
evidence, or decline a nit as a follow-up.

## Stop

- Approved: APPROVE with no blocker or should open.
- Stuck: a dispute survives two replies, or the rounds run out. Show both
  sides and let the user decide.
- No reviewer could run: put a "Not reviewed" warning at the top of the PR
  description and follow the repo's rule for a review that can't run.

Add to the PR description:
`Reviewed with sol-loop: <N> rounds with <model(s)>. Sol verdict: approved`
