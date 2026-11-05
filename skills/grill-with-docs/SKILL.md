---
name: grill-with-docs
description: Relentless interview to stress-test a plan against the codebase, writing GLOSSARY.md and ADRs as we go. Only run when the user asks.
disable-model-invocation: true
---

Interview me about this plan until we share one understanding of it.

- Ask in rounds. Each round holds every question you can ask now without
  needing an answer from the same round. Number each question and give your
  recommended answer.
- Look up facts in the code yourself; only ask me for decisions. Never answer
  a decision for me.
- Point out when my words or answers conflict with each other, GLOSSARY.md,
  or the code.
- When a term is settled, add it to GLOSSARY.md right away: the term, a
  one-line definition, and words to avoid. No implementation details.
- Only offer an ADR (docs/adr/0001-slug.md, a few sentences) for a decision
  that is hard to reverse, surprising to a future reader, and a real
  trade-off.
- When nothing is left to ask, list every decision we made and every file you
  changed, then wait for me to confirm. Don't act until I do.
