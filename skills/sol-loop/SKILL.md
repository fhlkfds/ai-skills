---
name: sol-loop
description: Use when the user says "sol loop".
---

# sol-loop

Have an outside model review your change in a loop, before or after filing a
PR. Make the smallest changes that satisfy it, and push back on scope creep.

`~/.claude/CLAUDE.md` names the reviewers and their CLI commands. The repo's
`AGENTS.md` sets round limits, review guidelines, labels and merge rules. If
it doesn't set a round limit, use 3, or 5 while a blocker is open on
security, auth, data loss or concurrency.

## 1. Scope

- Run `git status --short` and review only this change's paths. If unrelated
  changes can't be separated, ask.
- Run `git fetch origin`. The base is `git merge-base HEAD origin/<PR base or
  default branch>`. For a PR, `HEAD` must be the PR head or ahead only by
  this change. With no remote, use the base the user names, or `HEAD`.
- The diff runs from the base to the working tree, plus untracked files. Use
  the same diff every round.
- Run the covering checks. Fix anything this change breaks, and note missing
  or failing checks in the brief.

## 2. Run a round

1. Run `~/.claude/skills/sol-loop/codex-limits.sh`. Use Codex unless it
   prints `BLOCKED`, then Grok. Once a loop is on Grok, it stays on Grok.
2. In T3, start the review with `delegate_task` (`role: "review"`,
   `mode: "async"`, effort in `target.options`, a new `clientRequestId` each
   round). Outside T3, run the CLAUDE.md command in the background. Every
   round is a fresh run with the full brief and the ledger.
3. Wait for the notice or the exit. Don't edit scoped files until then.
4. If the reviewer hits a usage limit (`429`, or a usage, rate or quota
   error), rerun the round on Grok. If Grok is out too, see "No reviewer" in
   section 4. Retry any other error once, then follow the repo's rule for a
   review that can't run. A failed review is not approval.

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

Later rounds send the same brief plus the ledger and the change since the
last round. Ask only about open ids and changed code, each marked `resolved`
or `still open: <reason>`.

## 3. Answer findings

Judge each finding yourself. Rare cases, other paths and small costs are nits.

- Agree: make the smallest fix, preferring to delete or narrow code. Add one
  test that fails without the fix if the intent needs it.
- Disagree: answer with evidence (file:line, a test, output).
- Nit or out of scope: decline in one line and list it as a follow-up.

Keep a ledger of id, severity and outcome. Re-run the checks and
`git diff --shortstat <base>`. If the review grew the diff, cut it back.

## 4. Next round or stop

Run another round only if budget remains and a blocker or should is open, or
behavior changed since the last approval. A round with only nits ends the
loop.

- Approved: APPROVE on the current diff, with no blocker or should open.
- Stuck: a dispute survives two replies, or the budget runs out. Show both
  sides in 2 or 3 lines and let the user decide.
- No reviewer: Codex and Grok are both out. Don't wait. Put this at the top
  of the PR description, follow the repo's rule for a review that can't run,
  and stop:

  ```
  > [!WARNING]
  > **Not reviewed.** Codex and Grok were both out of usage. Codex is back <time from codex-limits.sh>.
  > Open findings: <ids, or none>.
  ```

## 5. Ship

Push only if the user asked. Add this line to the PR description:

`Reviewed with sol-loop: <N> rounds with <model(s)>. Sol verdict: approved`

If Grok reviewed, name it and say why. Report the rounds, reviewers, fixes,
declined findings with reasons, diff size before and after, and whether you
pushed.
