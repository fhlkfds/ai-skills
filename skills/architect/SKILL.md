---
name: architect
description: >-
  Sketch the shape of a change (types, signatures, modules) before any code,
  let the user pick from labelled options, then keep the build true to the
  pick. Use for /architect, "architect this", "design this", or non-trivial
  work where jumping to code would lock in the wrong shape.
---

# Architect

No code until the user picks a shape.

1. If what to build is still fuzzy, run `grill-me` first. Then trace every
   part of the system the change touches, with the `how` skill.
2. Sketch two or three shapes, labelled A, B, C. Each one names its types,
   function signatures and module boundaries, and who owns each piece of
   data. Prefer the shape where each piece of data has one owner, each job
   has one way to do it, and callers need to know least. If the same
   workaround keeps showing up, redesign instead of patching.
3. Draw each shape side by side (boxes for modules, arrows for calls, the
   data owner marked). Show it the best way the program allows:
   - a tool that shows HTML in the chat (T3 Code: `html_preview` then
     `html_render`; Claude.ai and Claude Code: an artifact)
   - otherwise a self-contained HTML file in `/tmp`, opened with
     `xdg-open` (Linux) or `open` (macOS), with its path in the reply
   - with no display, a text diagram in the reply
4. Reply with your pick in one line, then the pictures, then a small table:
   shape, what it's good at, what it costs. End with numbered questions,
   each with your pick. Wait for the go.
5. For a big or disputed design, run `council` on the sketches: each model
   picks a shape and says why. Show where they disagree.
6. Save the picked sketch and the reason in the branch as
   `docs/design/<topic>.md`, unless the repo keeps designs elsewhere. Every
   prompt for a worker or another thread links to it.

## While it's built

Before each piece is called done, or handed to the next worker, compare it
with the sketch.

- A change the user or the sol-loop reviewer accepts goes into the sketch,
  with who accepted it.
- A change nobody accepted, or a disagreement, stays listed at the bottom
  of the sketch until it's settled.
- Never edit the sketch just to match what got built.
