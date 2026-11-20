---
name: arena
description: >-
  Have Claude, Codex and Grok each build the same thing in parallel, score
  them against a rubric, pick a base and graft in the best parts of the
  others. Use for /arena, "arena this", "throw it in the arena", or when one
  attempt at a non-trivial artifact would lock in the wrong shape.
---

# Arena

## 1. Frame

Everyone gets the same prompt, so the prompt is the contract.

- Say what each runner builds.
- Write a rubric of 3 to 6 pass/fail or 1-to-5 checks for this task. Keep
  it from the runners. It's for judging.
- Runners, one per provider at high effort unless the user names others:
  Claude Opus 5.5, Codex `gpt-6.1-sol`, Grok `grok-4.7`. Add a second run of
  a model for extra design directions. If one can't run, drop it, keep at
  least two, and say so. Don't swap in another model.
- Give each runner its own git worktree off trunk.

## 2. Fan out

Start every runner at once. In T3 Code, use `delegate_task` per runner with
`isolation: "worktree"`. Elsewhere, spawn a Claude subagent and run the
`codex exec` and `grok -p` commands from `~/.claude/CLAUDE.md` in the
background, with write access to that runner's worktree only (Codex:
`-s workspace-write`). Each runner builds the thing and writes a short note
on what it tried and what it threw out. A runner that returns nothing drops
out; note it.

## 3. Judge

Score every runner against the rubric, check by check, after reading each
one in full. Also ask one read-only judge from a different provider than
yours to score them by label (A, B, C) without model names. If you and the
judge pick different bases, read both notes again before deciding.

## 4. Show the scorecard

Draw a table or chart of each runner's score on each check, with your pick
of base. For anything visual, add labelled screenshots side by side. Show
it the best way the program allows:

- a tool that shows HTML in the chat (T3 Code: `html_preview` then
  `html_render`; Claude.ai and Claude Code: an artifact)
- otherwise a self-contained HTML file in `/tmp`, opened with `xdg-open`
  (Linux) or `open` (macOS), with its path in the reply
- with no display, a text table in the reply

For a visual result, wait for the user's pick. Otherwise go with yours.

## 5. Graft and verify

Take the base, then port the one or two best ideas from each other runner,
rewritten to fit the base rather than pasted in. If all runners land on the
same shape, ship that and say they agreed. If they're all over the place,
the prompt was too loose: reframe and run again.

Verify the result on the real app. If it fails, the frame was wrong or you
missed a graft. Go back to that step.

**Reply:** the scorecard, the base and why, each graft and where it came
from, dropouts, and the proof it works.
