---
name: rebase-open-branches
description: "Use when a PR merges and other PRs or agent branches stay open."
version: 1.2.0
author: hermes-orchestrator
license: MIT
platforms: [linux]
metadata:
  hermes:
    tags: [Git, Workflow, Coding-Agent]
    related_skills: [t3-code, github]
---

# Rebase Open Branches and Clean Up After a Merge

Run this every time one PR merges while other PRs/branches in the same repo
are still open — regardless of which agent created them (t3 threads, Claude
Code, Codex, or human). It updates every remaining branch onto the new `main`
so the next merge is conflict-free, and deletes the worktree and branch of the
PR that just merged so dead work does not pile up.

## Trigger

Auto-load when any of these happen:
- The user asks to merge a PR and other open PRs/branches exist in the repo.
- A PR merge is confirmed (`gh pr merge` output, or the user reports one).
- The user reports a merge conflict between two open branches.

If the user only says "merge PR N", do the merge AND this skill's protocol in
one run — do not wait to be asked to rebase or clean up.

## Protocol

1. **Find the open branches and the merged PR's worktree.**

   ```bash
   gh pr list --repo <owner>/<repo> --state open --json number,headRefName,title
   git -C <repo> worktree list
   ```

   Skip the PR that just merged (it goes to step 2 instead). Record each open
   branch name and its worktree path. For t3 threads, worktree paths come from
   `npx t3 thread list --project <path>`.

2. **Clean up the PR that just merged (worktree + branch).**

   Guards — all must pass before deleting anything:
   - Confirm the PR is merged on GitHub:
     `gh pr view <pr-number> --repo <owner>/<repo> --json state,mergedAt`
   - The worktree to remove must NOT be the primary checkout (the first entry
     in `git worktree list`, i.e. the repo root itself).
   - The branch must NOT be `main`, `master`, `develop`, or the repo's default
     branch.
   - The worktree must be clean: `git -C <worktree> status --porcelain` must
     return nothing. If it shows uncommitted edits, STOP and show them to the
     user instead of deleting.

   Then delete:

   ```bash
   git -C <repo> worktree remove <worktree-path>
   git -C <repo> branch -d <merged-branch>          # -d refuses if unmerged; that is a feature
   git push origin --delete <merged-branch>          # skip if GitHub already deleted it
   ```

   **t3 exception:** t3 owns its thread worktrees. Do not `git worktree remove`
   a t3 worktree by hand — close or archive the thread instead so t3 cleans up
   its own state:
   `npx t3 thread close mcp:<thread-id>` (or archive per t3's CLI). Only if
   t3 leaves the worktree behind after the thread is closed, remove it with
   the guarded commands above.

   If `git branch -d` refuses because git thinks the branch is unmerged,
   verify the PR shows merged on GitHub first; only then use `-D` with the
   PR link in the output as evidence.

3. **Update main locally.**

   ```bash
   git -C <repo> fetch origin
   ```

4. **Rebase each open branch onto origin/main.**

   Choose the path by who owns the branch:

   **a. t3 thread (idle/finished):** send a follow-up so the agent resolves
   conflicts inside its own worktree:

   ```
   npx t3 thread send mcp:<thread-id> 'Run: git fetch origin && git rebase origin/main. If conflicts: resolve them by keeping the current main version for merged-in changes and preserving this branch'\''s own feature changes; never drop either side blindly. After rebase, re-run the project build/test check, then push with git push --force-with-lease. Report any conflict you could not resolve confidently instead of guessing.' --wait
   ```

   **b. Any other agent branch (Claude Code, Codex, human, unknown):** if a
   checkout of the branch exists locally and is not actively being edited,
   rebase it directly:

   ```bash
   git -C <repo> rebase origin/main    # while on that branch
   # on conflict: fix files, git add, git rebase --continue
   git push --force-with-lease
   ```

   **c. No local checkout (branch exists only on GitHub):** update the PR
   itself:

   ```bash
   gh pr update-branch <pr-number> --repo <owner>/<repo>
   ```

5. **Verify before merging the next PR.**

   ```bash
   git -C <repo> log --oneline -3        # branch sits on top of latest main
   git -C <repo> status                  # clean, no rebase in progress
   gh pr checks <pr-number> --repo <owner>/<repo>   # CI green on updated branch
   ```

   Only merge the next PR after its branch passes this check. Then repeat
   step 2 (cleanup) for the newly merged PR and continue the loop.

6. **If a conflict cannot be auto-resolved**, stop and report it to the user
   with both sides of the conflict quoted verbatim. Do not pick a winner.

## Order rule

One PR at a time: merge → clean up the merged one → rebase the rest → verify
→ merge the next. Rebase only the branch that will merge next when time is
short.

## Prevention

- Start each new agent task only after `git -C <repo> pull` on main.
- Partition tickets so two running agents never edit the same files.
- Use squash merges to keep main linear and rebases trivial.

## Pitfalls

1. **Never remove the primary checkout or `main`/`master`/`develop`** — the
   guards in step 2 are hard rules, not suggestions.
2. **Never `push --force`** — always `--force-with-lease`, or you can clobber
   a CI-updated branch.
3. **Never rebase a checkout an agent is actively editing** — uncommitted
   edits will be lost or trapped. Send the instruction to the agent, or wait.
4. **Never delete a dirty worktree** — uncommitted files are real work; stop
   and show the user what is in the folder instead.
5. **Aborted rebase leaves state behind** — if resolution fails,
   `git rebase --abort` restores the branch; do not leave a half-rebase.
6. **t3 thread IDs include the `mcp:` prefix** in every t3 command, and t3
   worktrees belong to t3 — close the thread, let t3 clean up.
7. **`gh pr update-branch` only works with a clean GitHub history** — if the
   PR carries old merge commits, prefer a local checkout and path b.