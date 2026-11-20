---
name: arena
description: >-
  Race Claude, Codex and Grok on the same task, pick a base, and graft the
  best parts of the others into it. Use for /arena, "arena this", "throw it
  in the arena", or when one attempt at a non-trivial build would lock in
  the wrong shape.
---

# Arena

## 1. Frame

Every runner gets the same prompt, so the prompt must describe the whole
task.

- Say what each runner builds.
- Write a rubric of 3 to 6 checks for this task, each pass/fail or scored 1
  to 5. Use it to judge, and don't show it to the runners.
- Use one runner per provider at high effort, unless the user names others.
  That means the newest Claude Opus, the newest GPT Sol on Codex, and the
  newest Grok. Run a model twice to get more design directions. If a model
  can't run, drop it, keep at least two runners, and say so. Don't swap in
  a different model.
- Give each runner its own git worktree off trunk.

## 2. Fan out

Start every runner at once, each in its own worktree. Use the program's
tool for starting agents on other models if it has one. Otherwise, spawn a
Claude subagent and run the `codex exec` and `grok -p` commands from
`~/.claude/CLAUDE.md` in the background. Give each one write access to its
own worktree only (for Codex, `-s workspace-write`). Each runner builds the
thing and writes a short note on what it tried and what it rejected. If a
runner returns nothing, drop it and say so.

## 3. Judge

Read each runner's work in full, then score it against the rubric one
check at a time. Ask one read-only judge from a different provider than
yours to score them too. The judge sees the runners as A, B and C, without
model names. If you and the judge pick different bases, read both runners'
notes again before you decide.

## 4. Show the scorecard

Draw a table or chart of each runner's score on each check, and mark the
base you pick. For visual work, add labelled screenshots side by side.
Show it the best way the program allows:

- a tool that shows HTML in the chat
- otherwise a self-contained HTML file in `/tmp`, opened with `xdg-open`
  (Linux) or `open` (macOS), with its path in the reply
- with no display, a text table in the reply

For visual work, wait for the user to pick. Otherwise go with your pick.

## 5. Graft and verify

Start from the base. From each other runner, take the one or two best
ideas and rewrite them to fit the base. Don't paste code across. If every
runner built the same shape, ship it and say they agreed. If they all built
something different, the prompt was too loose. Rewrite it and run again.

Test the result in the real app. If it fails, either the prompt was wrong
or you missed a graft, so go back to that step.

**Reply** with the scorecard, the base and why you picked it, each graft
and which runner it came from, any runner that dropped out, and the proof
it works.
