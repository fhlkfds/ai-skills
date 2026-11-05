---
name: rebase-open-branches
description: Rebase open branches onto main after a PR merges, and clean up the merged work
---

# Rebase open branches

## Trigger

A PR just merged while other PRs or agent branches are still open in the repo.

## Workflow

1. List open PRs and their worktrees; skip the one that just merged.
2. Delete the merged PR's worktree, local branch, and remote branch — only after confirming it is merged and the worktree is clean.
3. Fetch origin and rebase every remaining open branch onto origin/main.
4. Resolve conflicts minimally: keep both sides when safe, else the version that compiles; regenerate lockfiles with the package manager, never hand-edit.
5. Prove the branch: no conflict markers left, build/tests pass, then push with --force-with-lease.
6. Verify CI is green, merge the next PR, and repeat from step 2.

## Guardrails

- Never remove the primary checkout, main/master/develop, or a dirty worktree.
- Never force-push; use --force-with-lease. If a conflict cannot be resolved confidently, stop and show the user both sides.
- t3 threads: close the thread and let t3 remove its own worktree; send rebases as follow-up messages instead of editing live worktrees.

## Output

- Branches rebased and worktrees removed
- Conflicts resolved and tests run
- Ready-to-merge PR