# Shared task workflow

Apply these rules to a workflow the user started with `task-flow:complex-task` or `task-flow:simple-task`. The main session coordinates the work and owns the final report. Follow the target project's instructions and access restrictions in every agent brief and command.

## Start and approval

- Establish requirements, scope, acceptance checks, and the implementation owner. Keep the main session's current model.
- The reviewer defaults to the `sonnet` alias. Honor a reviewer model explicitly requested for this task, including natural language such as "reviewer 用 opus". Record the selection in any plan or continuation checkpoint and apply it only to the reviewer's Agent invocation. Successful resolution through the user's configured alias mapping satisfies the model selection, including mappings to a differently named backend. Report the requested alias and resolved backend when known; do not repeat or reject a completed review solely because those names differ.
- Before edits, record the repository baseline and relevant existing staged, unstaged, and untracked changes using commands that exclude restricted paths. Preserve enough before-state for overlapping dirty files to distinguish this task's delta. For non-git files, record the relevant original content. Preserve unrelated work; do not reset or stash it to make review easier.
- `--plan`, "先写计划，等我确认", or an already active Plan Mode requires a pause before implementation. Enter Plan Mode when needed, prepare the plan, and use `ExitPlanMode` for approval. If plan tools are unavailable, present the plan and stop for the user's explicit approval. Until approved, do not edit application files or start implementers. Without an approval request, show the necessary plan and continue authorized work.
- An approval plan records the workflow name, task, scope, constraints, baseline, acceptance checks, reviewer model, next stage, and this shared file's resolved absolute path. Include the implementation, independent review, repair, and human-handoff stages so approval with cleared context retains the whole workflow.
- After the user approves, continue the recorded stage of this already-started workflow. The original `--plan` request is satisfied; do not ask for the same approval again or invoke the user-only entry skill through the Skill tool. New workflow tasks require a new user invocation.

## Implementation and ownership

- For complex tasks, invoke `task-flow:dispatch` and delegate implementation and integration edits to `task-flow:implementer`. For simple tasks, decide whether direct implementation or delegation fits the work.
- Keep related implementation, caller changes, and necessary core tests together. Assign explicit modification scopes and acceptance checks to delegated work.
- Record each implementer's returned identifier, task, owned paths, workspace, and check results. Preserve that mapping in any continuation checkpoint.
- Inspect the integrated result and run the target project's required acceptance checks before review. Report failures accurately; fix attributable implementation failures before requesting independent review where possible.

## Independent review

- Review the delta introduced by this task, including new files and relevant connected code. Provide the starting baseline and pre-existing changes so the reviewer can distinguish attribution. If attribution is uncertain, resolve it or report the limitation instead of silently expanding the review.
- An empty task delta means NO_CHANGES; do not review the previous commit as a substitute.
- Once all implementation and integration edits finish, start a new Agent with `subagent_type: "task-flow:reviewer"`. Use the ordinary fresh-context invocation, not `fork`, an implementation agent, or a resumed previous reviewer.
- Without a user override, use the agent definition's Sonnet default. With an override, pass the selected `model` explicitly to the Agent tool. If the requested model cannot be selected, report the blocker instead of silently using another model.
- Supply the user requirements, approved contracts, workspace, baseline, actual task delta, related paths, access restrictions, and factual acceptance results. Keep author self-review hypotheses and suggested findings out of this brief so review is independent.
- Require actual invocation of `ponytail:ponytail-review`. A failed or unavailable review is a blocker, not a clean result. Wait for the report before starting review-driven repairs.

## Assess and repair

- Preserve each finding's ID, severity, and evidence. Route findings by implementation ownership, including all claims that require assessment.
- For delegated code, use `SendMessage` to resume the original implementer with its findings and scope. If it cannot be resumed, disclose that and brief a new `task-flow:implementer` with the original task, current changes, findings, and constraints. For code written directly in a simple task, assess and repair it in the main session.
- Require a disposition for every finding: ACCEPTED with the fix and check results; REJECTED with concrete requirement/code/reproduction evidence; or BLOCKED with the consequence and needed decision. A review opinion alone is not proof; check the underlying claim.
- Coordinate scope and contract changes before repairs. Sequence overlapping repairs; keep independent ownership explicit.
- Inspect the dispositions and final diff, then run checks appropriate to the repairs and the integrated result. Resolve unsupported rejection claims or report the unresolved disagreement. Do not label failed checks or unresolved blocking findings as passed.
- Default to one independent review followed by assessment, repair, and validation. A further full review is a separate user choice; ordinary validation of the repairs is part of this workflow.

## Human handoff

Report the change summary, review scope and model used, acceptance results, each finding's disposition, and unresolved issues or unchecked areas. Say the result is ready for human review, or identify the blockers that remain. The reviewer's "Ship" recommendation is advisory. Stop here; do not automatically commit, push, open a PR, or publish.
