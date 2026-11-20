---
name: why
description: >-
  Use for "why does X work this way", "why we picked Y", design rationale,
  regressions, postmortems, or data-backed thresholds. Returns a cited read
  on decisions and tradeoffs in plain words with a timeline and pictures.
  Use how for runtime behavior.
---

# Why

Answer "why is it like this?" from the record, not from reading the code.
Lead with the answer, keep each chunk short, and let a picture carry the
detail.

This is read-only. Don't change code.

## 1. Pin the question

Name the thing you're explaining: a file, a function, a setting, a number,
a behavior. If the question could mean more than one thing, say which one
you're answering in one line and go.

## 2. Dig through the record

Hand the digging to one read-only subagent so the history stays out of the
main thread. On Claude Code, use the `Explore` agent. If you can't spawn
one, dig yourself. Give it the question and this brief:

> Find the history behind this. Start with `git log` and `git blame` to find
> the commit that introduced it and each later commit that changed it. For
> each one, read the commit message and the PR it came from (`gh pr view
> <n> --comments`), plus any linked issue. If that trail is thin, check
> docs, ADRs, changelogs and code comments near it. Report a dated list:
> what changed, who changed it, and why, quoting their words with a link
> or SHA. Name the options they turned down and why. Say plainly what the
> record doesn't explain. Don't fill gaps with guesses.

Check each quote you'll repeat against its source before you use it.

## 3. Draw it

Pick the picture that fits:

- a timeline: each change on a line, dated, with a few words on why
- a fork: the options they had, the one they picked, and what tipped it
- before and after: what broke or hurt, and what the change did about it
- a chart: for a threshold or number, the data that set it and where the
  line was drawn

If you can render HTML (in T3 Code, `html_preview` then `html_render`),
draw it there and label everything in plain words. Otherwise draw a text
diagram in the reply. Keep it to what matters: five to eight points on a
timeline, not every commit.

## 4. Write it

In this order, with short headings so the reader can jump around:

1. **The answer.** One or two sentences, no jargon: "It's like this
   because ..."
2. **The picture** from step 3.
3. **How it got here.** A numbered list, oldest first. One change per
   item, two lines at most, with its date and a link or short SHA at the
   end.
4. **What they gave up.** The tradeoff in a sentence or two, or a small
   table: option, upside, downside, picked or not.
5. **What the record doesn't say.** The gaps. Leave this out if there are
   none.

Rules for the whole reply:

- Quote the authors when you say why. Mark your own reasoning with
  "my guess:" so it never reads as a fact.
- Explain a term the first time you use it, or skip it.
- Use an everyday comparison when the idea is abstract.
- No walls of text. If a paragraph runs past three lines, split it or turn
  it into a list.
- If the question is really "how does this work today", that's the `how`
  skill.
