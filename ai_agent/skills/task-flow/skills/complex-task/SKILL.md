---
name: complex-task
description: Run a complex implementation task through planning, delegated implementation, independent review, repair, and human review. Invoked explicitly by the user.
argument-hint: "[--plan] <task>; optionally specify the reviewer model"
disable-model-invocation: true
---

Task: $ARGUMENTS

Read `${CLAUDE_SKILL_DIR}/../../references/workflow.md` and follow it throughout this task. Keep the main session's current model.

1. Apply the shared discussion and requirement rules first: answer questions directly and distinguish material implementation assumptions from user requirements. For authorized implementation, establish the task scope, review baseline, reviewer model, and whether the user requested plan approval.
2. Invoke `task-flow:dispatch` through the Skill tool for the implementation task. Pass the task, constraints, material assumptions, acceptance requirements, and approval requirement. On an approved-plan continuation, pass the approved plan and resume its recorded stage; incorporate requirement changes into the affected entries.
3. Coordinate implementation through `task-flow:implementer`. Delegate application edits, integration fixes, and conflict fixes to implementers. Record their agent identifiers and owned scopes for repair.
4. Once implementation and integration are complete, continue through the shared independent-review, finding-disposition, validation, and human-handoff steps. Dispatch's summary is an intermediate result in this workflow.
