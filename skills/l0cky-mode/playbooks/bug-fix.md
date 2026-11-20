# Bug fix

You own this task. Plan, review, verify. Delegate investigation and the fix
to subagents, and stay in the lead. Pick each subagent's reasoning level for
its job: higher for hard or subtle work, lower for routine work.

Be scientific. Every shipped line traces to runtime evidence. A
belt-and-suspenders change that "might help" is a hypothesis, not a fix, and
it doesn't ship. When evidence refutes a hypothesis, revert what it
motivated. Ship the smallest change the evidence justifies, nothing more.

1. **Reproduce it yourself** on the matching surface through the project's
   control skill, even when a debug or instrumentation protocol says to ask
   the user to reproduce. Ask the user only after driving the surface as
   far as it goes, and give the specific reason it can't reach the target.
   If the bug won't reproduce directly, synthesize the trigger, tighten the
   conditions, or instrument until it fires.
2. **Binary-search the cause.** Form the candidate hypotheses, then rule
   them out until one survives. Seed them with a trace of the affected
   subsystem and the `why` skill for regression history. Each pass, take
   the split that cuts the most remaining problem space, get runtime
   evidence, and eliminate. When program state is unclear, add
   instrumentation or logging and read it as the code runs. Don't guess.
   Drive a long or stubborn hunt with `/loop`. Confirm the surviving
   mechanism with runtime evidence before step 3's `architect` or an
   `interrogate` fan-out.
3. **Plan the fix.** If it crosses a function boundary, run `architect`
   first. Delegate the implementation, with a specific scope, to a subagent
   on the bug-fix model: Opus 5.5 on xhigh unless the task names another.
4. **Verify on the same surface.** The original repro now passes.
   "Inconclusive" or a result from the wrong surface is not a pass, so flag
   it. Unit tests show branch behavior, not that the bug is gone.
5. **Stage the commits** so the failing repro lands before the fix in git
   history. This is the `sequence-verifiable-units` principle: the failing
   test first, the fix on top. When the bug has a cheap local test path,
   follow the `tdd` skill's failing-test-first cadence. Skip it when the
   test would be expensive, integration-heavy or unclear.
6. **Open the PR** with [opening-a-pr.md](opening-a-pr.md).

**Reply:** what was broken, the root cause, the fix and how you verified
it. Paste the failing-then-passing repro output verbatim.
