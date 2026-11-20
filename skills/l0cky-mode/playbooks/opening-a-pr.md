# Opening a PR

1. Work in a git worktree off trunk. Keep unrelated work out of it.
2. Rebase into small commits that can each land on their own.
3. Run `/deslop`.
4. Write the PR body with the template below.
5. Stack follow-ups by base branch: each follow-up PR targets the branch
   of the PR it builds on.
6. Open the PR ready for review, through the run's PR tool with
   `draft: false`. Without one, use `gh pr create` without `--draft`, or
   `origin pr create --status open` when Origin's CLI resolves the
   repository.

Opening a PR doesn't start a babysit.

## PR template

```markdown
<!--
One problem per PR. Use a conventional title in plain language:
  good: fix(ssh): reconnect after the laptop wakes from sleep
  bad:  fix bugs / update docs
Draft PRs are fine for unfinished work. Don't merge on red CI.
-->

## Problem
<!-- What is wrong or missing? Who sees it, on which platform, how often?
     Back any speed or memory claim with numbers. -->

Closes #
<!-- Regression? Fixes: <12-char sha> ("subject of the commit that broke it") -->

## Change
<!-- How does this fix it? Cleanup, refactors and a second fix go in their own PRs. -->

## How I verified it
<!-- What you ran and what you saw. "Tests pass" is not enough.
     Say what you could NOT check (e.g. WebView2, real audio devices). -->
- Steps and result:
- Not checked:

## Screenshots / recording
<!-- Before/after for UI changes. Upload to this PR; don't commit PR-only images. -->

## Compatibility

## Release notes
Notes: <!-- One past-tense line for users, e.g. "Fixed SSH reconnect after sleep." Or `none`. -->

## Self-review
```
