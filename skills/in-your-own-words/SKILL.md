---
name: in-your-own-words
description: >-
  Restate what I'm after and the problem behind it, in plain words with
  pictures and examples, plus the defaults you would pick, then wait for my
  go. Use for /in-your-own-words or "explain in your own words what I mean".
disable-model-invocation: true
---

Tell me in your own words what I'm asking for, before you do any of it. Use
whatever helps me see that you got it: words, pictures, examples.

Don't change anything yet. Read files only to check that my premise holds.

Answer in plain words, as if I'm not an engineer, in this order:

1. What I want. One or two sentences in your words. Don't echo mine back.
2. Why I want it. The problem it solves, or what goes wrong today.
3. A picture of it. Pick what fits:
   - a before-and-after diagram: how it works today, how it will work after
   - a flow of the steps, with boxes and arrows
   - a rough sketch of the screen or output I'll end up with
   - one real example walked through from start to end
   - an everyday comparison, if the idea is abstract

   If you can render HTML (in T3 Code, `html_preview` then `html_render`),
   draw it there. Otherwise draw it in the reply as a text diagram.
4. What you would do. The defaults you'd pick: scope, approach, and where
   the work stops (an answer, a plan, a PR). Mark the ones that are guesses.
5. What you're unsure of. Numbered questions, each with your pick, so I can
   reply "1. a 2. yes". Leave this out if there's nothing.

- I dictate and type fast. If you read a word as something else, such as
  "croc" as Grok, say so.
- If the code says my premise is wrong, say so with `file:line` and stop
  there.
- Keep the words short and let the picture carry the detail.
- Then wait. "go", "yes" or "do what you recommend" means act on the
  defaults you gave.
