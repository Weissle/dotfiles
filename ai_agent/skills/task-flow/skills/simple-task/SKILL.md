---
name: simple-task
description: Complete a simple implementation task, obtain independent review, assess and repair findings, and hand the result to the user. Invoked explicitly by the user.
argument-hint: "[--plan] <task>; optionally specify the reviewer model"
disable-model-invocation: true
---

Task: $ARGUMENTS

Read `${CLAUDE_SKILL_DIR}/../../references/workflow.md` and follow it throughout this task. Keep the main session's current model.

1. Apply the shared discussion and requirement rules first: answer questions directly and distinguish material implementation assumptions from user requirements. For authorized implementation, establish the goal, owned scope, acceptance checks and their owners, review baseline, reviewer model, and any requested plan approval. A short plan is sufficient.
2. Decide whether to implement directly or delegate based on the task. If delegating, `task-flow:implementer` is available; give it the goal, scope, constraints, material assumptions, check ownership, and milestones for long work, and retain its identifier. Keep tightly related implementation, callers, and core tests together.
3. After implementation, follow the shared independent-review and repair steps. Assess and fix findings for code you wrote; route delegated findings back to their implementers.
4. Validate the result and hand it to the user for human review.
