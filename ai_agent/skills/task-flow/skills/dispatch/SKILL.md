---
name: dispatch
description: Plan a code change, check the plan, then delegate cohesive tasks to implementer subagents. Use when implementation should be delegated, with the main session coordinating dependencies, integration, and validation.
---

You are the planner and coordinator in the main session. Own the overall plan, task boundaries, shared contracts, integration, and final validation. Implementers own local implementation decisions within their assigned scope.

1. **Plan and check.** Explore the relevant code and prepare an overall implementation plan before dispatching work. Check requirement coverage, feasibility, affected callers and tests, dependencies, shared interfaces, and validation. Resolve gaps before assigning tasks. Present the checked plan briefly; proceed within the user's authorization unless they requested plan approval or an unresolved requirement or design tradeoff needs their decision. When continuing an approved plan, check it against the current workspace and resume the recorded stage.

2. **Assign tasks.** Derive task cards from the checked plan. Decide the number of agents and what each owns based on shared context and dependencies. Keep tightly coupled implementation, caller changes, and core tests together so each task delivers a coherent result. One task and one subagent are valid; do not split work just to create parallelism. Each card includes:
   - Goal and acceptance criteria
   - Relevant context, starting files, and the task's role in the overall plan
   - Owned modification scope, including related callers and tests
   - Required contracts, interfaces explicitly marked as fixed, and out-of-scope work
   - Dependencies and required inputs
   - Acceptance commands appropriate to the change and target project

   Specify outcomes and constraints; leave local implementation details to the implementer.

3. **Dispatch and coordinate.** Send each card to `task-flow:implementer` via the Agent tool. Record each returned agent identifier, scope, workspace, and acceptance results. Run tasks concurrently when dependencies are satisfied and edits and shared contracts do not conflict; sequence dependent or overlapping work. Use `isolation: worktree` when separate workspaces are needed, and ensure each isolated task has the required starting changes before it runs. Do not duplicate active delegated work in the main session.

4. **Handle BLOCKED.** Check the obstacle against the overall plan. Refine scope, contracts, or dependencies and update affected tasks before continuing. Use `SendMessage` to continue the original implementer when available; do not resend an unchanged task. Ask the user only when the resolution needs their decision.

5. **Integrate and validate.** Integrate isolated results while preserving unrelated work. Delegate conflict fixes and integration code changes to implementers with the required ownership. Inspect the combined diff against the plan and the project's contracts, performance constraints, and invariants. Run acceptance checks from the target project's instructions and available tooling; instruction-only changes use appropriate static checks. Subagent reports are inputs, not a substitute for inspecting and validating the integrated result.

6. **Report.** Summarize assignments, changes, checks, and remaining blockers. When called by `task-flow:complex-task`, continue with that workflow's independent review and repair before the final human handoff. Do not commit unless asked.
