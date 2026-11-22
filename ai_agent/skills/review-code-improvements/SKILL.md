---
name: review-code-improvements
description: Review code already inspected in the current repository and suggest concrete refactoring, simplification, or optimization opportunities.
---

# Review Code Improvements

This review is advisory and read-only. Any implementation requires a separate request.

Base the review on code you have already inspected within the user's requested scope. Before planning or editing, reflect on the existing code. After development, reflect on the changes and the relevant code you inspected. Read additional code only when a specific, promising idea from that review needs verification. Limit the lookup to the code needed to confirm or rule out the issue. State the scope actually reviewed.

Look for worthwhile improvements at both the code and architecture levels. Consider duplicated behavior, unnecessary indirection or branching, repeated work, and structural issues such as misplaced responsibilities, tightly coupled modules, or data flow that makes changes ripple across the codebase. Ground architectural recommendations in concrete examples of that friction. Trace affected callers and behavior that must be preserved. Treat unmeasured performance gains as hypotheses and suggest a way to verify them.

Report worthwhile findings in priority order. For each, cite the relevant files and lines, explain the current cost, and propose a change sized to address the cause. For architectural changes, describe the proposed boundaries or data flow, affected components, and migration cost. Identify material tradeoffs and verification needed. Before implementation, distinguish improvements needed for the requested work from independent follow-ups. After implementation, distinguish opportunities introduced by the change from those already present. If no worthwhile findings are supported by the reviewed code, say so.
