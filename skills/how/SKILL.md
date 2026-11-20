---
name: how
description: >-
  Use for "how does X work", code walkthroughs before changing something, and
  placement / ownership / layering questions ("where should this live",
  "which package owns this", "is this the right layer"). Explains subsystem
  architecture, runtime flow and onboarding mental models in plain words
  with a picture. Use why for motivation.
---

# How

Answer from the code. Don't change anything.

1. Explore with a read-only subagent if you can. Follow one real request or
   event through the code, noting `file:line` for each step. For a
   placement question, find where similar things live and which layer owns
   them. Check every claim against the code before you repeat it.
2. Draw one picture: the flow of a request, the layers with "it goes here"
   marked, or a map of the files involved. Keep it under about 12 boxes.
   Show it the best way the program allows:
   - a tool that shows HTML in the chat
   - otherwise a self-contained HTML file in `/tmp`, opened with
     `xdg-open` (Linux) or `open` (macOS), with its path in the reply
   - with no display, a text diagram in the reply
3. Reply in this order:
   - **Answer:** one or two plain sentences. For placement, the pick first:
     "Put it in `X`."
   - **Picture.**
   - **Step by step:** a numbered walk through the example, one line each,
     with `file:line` at the end.
   - **Where things live:** a small table of piece, job and file.
   - **Watch out for:** gotchas, if any.

Explain jargon or skip it. No paragraph over three lines. Say what you
didn't check.
