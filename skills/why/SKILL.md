---
name: why
description: >-
  Use for "why does X work this way", "why we picked Y", design rationale,
  regressions, postmortems, or data-backed thresholds. Returns a cited read
  on decisions and tradeoffs in plain words with a picture. Use how for
  runtime behavior.
---

# Why

Answer from the history, not the code. Don't change anything.

1. Dig with a read-only subagent if you can. Use `git log` and `git blame`
   to find the commit that added it and each later change, then read their
   PRs (`gh pr view <n> --comments`) and linked issues. If that's thin,
   check docs and nearby comments.
2. Draw one picture: a timeline of the changes, the options they picked
   between, or the data behind a number. Build and show it with the
   `show-me` skill.
3. Reply in this order:
   - **Answer:** one or two plain sentences.
   - **Picture.**
   - **How it got here:** a numbered list, oldest first, one line each,
     with a date and SHA or link.
   - **Tradeoff:** what they gave up.
   - **Unknown:** what the record doesn't say.

Quote the authors for every "why", and mark your own reasoning "my guess:".
Explain jargon or skip it. No paragraph over three lines.
