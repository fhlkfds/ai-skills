---
name: how
description: >-
  Use for "how does X work", code walkthroughs before changing something, and
  placement / ownership / layering questions ("where should this live",
  "which package owns this", "is this the right layer"). Explains subsystem
  architecture, runtime flow and onboarding mental models in plain words with
  diagrams, laid out for a reader with ADHD. Use why for motivation.
---

# How

Answer "how does X work?" so I understand it after one read. Write for a
reader with ADHD: lead with the answer, keep each chunk short, and let a
picture carry the detail.

This is read-only. Don't change code.

## 1. Pin the question

If the question could mean more than one thing, say which one you're
answering in one line and go. I'll redirect if it's wrong.

## 2. Explore

Hand the exploring to one read-only subagent so the file reads stay out of
the main thread. On Claude Code, use the `Explore` agent. If you can't spawn
one, explore yourself. Give it my question and this brief:

> Explore the code that answers this question. Report back: the one-sentence
> answer; the parts involved and what each one does; the path a real
> request or event takes through them, step by step, with `file:line` for
> each step; where each piece lives; and anything surprising. For a
> placement question, also report where similar things live today and which
> layer or package owns them. Quote the code you rely on. Don't guess. Say
> what you couldn't find.

Check the claims you'll repeat against the code before you use them.

## 3. Draw it

Pick the picture that fits:

- a flow: boxes and arrows for the path a request takes
- layers: stacked boxes showing who calls whom, with "it goes here" marked
  for a placement question
- a map: the files or packages involved and how they connect
- a sequence: who talks to whom, in order, for anything with timing
- a chart: when the answer is about numbers, such as sizes, counts or time

If you can render HTML (in T3 Code, `html_preview` then `html_render`),
draw it there and label every box in plain words. Otherwise draw a text
diagram in the reply. Keep it under about 12 boxes. Split a bigger system
into an overview and one zoom-in.

## 4. Write it

In this order, with short headings so I can jump around:

1. **The answer.** One or two sentences, no jargon. For a placement
   question, give your pick first: "Put it in `X`."
2. **The picture** from step 3.
3. **Step by step.** A numbered walk through one real example, start to
   end. One idea per step, two lines at most. Put `file:line` at the end of
   the step, not in the middle of the sentence.
4. **Where things live.** A small table: piece, what it does, file.
5. **Watch out for.** Gotchas that would trip someone changing this code.
   Leave this out if there are none.

Rules for the whole reply:

- Explain a term the first time you use it, or skip it.
- Use an everyday comparison when the idea is abstract.
- No walls of text. If a paragraph runs past three lines, split it or turn
  it into a list.
- Say what you didn't check.
- If I ask why it was built this way, that's the `why` skill.
