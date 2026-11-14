# Task Flow

User-invoked Claude Code workflows for implementation, independent Ponytail review, repair, and final human review.

## Load

On this installation (Claude Code 2.1.318), plugins under `~/.claude/skills/<plugin-name>/` load in new sessions. This directory loads as `task-flow@skills-dir`. Start a new Claude Code session after installation or changes. For an explicit local load elsewhere:

```sh
claude --plugin-dir /absolute/path/to/task-flow
```

Requires the Ponytail plugin enabled with the `ponytail:ponytail-review` skill available. A missing review skill is reported as blocked. Task Flow shares Ponytail's installed review rules through that skill.

## Use

```text
/task-flow:complex-task 实现……
/task-flow:simple-task 修复……
/task-flow:complex-task --plan 实现……
/task-flow:simple-task --plan 修复……
/task-flow:complex-task 实现……，reviewer 用 opus
/task-flow:simple-task 修复……，先给我计划
```

Both entry skills are user-only (`disable-model-invocation: true`). They keep the current session model. Select the desired main model before invoking a workflow, for example `/model opus` for complex planning or `/model sonnet` for direct implementation. Model aliases resolve through the user's existing environment configuration.

| Component | Responsibility | Model |
| --- | --- | --- |
| `complex-task` | Plan through dispatch, delegate implementation, coordinate review and repair | Current session |
| `simple-task` | Decide whether to implement directly or delegate, then coordinate review and repair | Current session |
| `dispatch` | Check plans, assign cohesive tasks, coordinate integration and validation | Current session |
| `implementer` | Implement its assigned scope and assess returned review findings | Sonnet |
| `reviewer` | Invoke Ponytail in a fresh context and return findings | Sonnet; overridable per invocation |

The reviewer model can be selected in the task request using a model supported by Claude Code's Agent tool. It affects the reviewer only. A model alias selects its configured backend, including a backend with a different name; that mapping satisfies the selection. Each review uses a new reviewer; the coordinating agent sends findings back to their implementation owner for evidence-based assessment and repairs.

`--plan` or an explicit request to approve the plan pauses before implementation. Approve through Claude Code's plan flow to continue the same workflow. If native plan tools are unavailable, the workflow presents the plan and waits for explicit user approval. The plan records the remaining review and repair stages, including when context is cleared. Complex tasks get a full plan; simple tasks get a short one.

Plans and task cards distinguish user requirements from implementation assumptions. Proposed public interfaces and added core constraints need a concrete use case and a gap in existing behavior. Routine local choices remain with the implementer.

Long tasks use independently verifiable scopes or intermediate milestones. Implementers use `SendMessage` to report completed milestones, material assumptions, and blockers to their coordinating parent. The coordinator relays meaningful progress and continues through review and repair before final handoff.

Acceptance commands have explicit owners: implementers normally run focused checks, and the coordinator runs integration and required full-project checks. Results include the checked code state, configuration, and log or output evidence. Verified results can be reused for unchanged relevant code and inputs; edits, integration, environment changes, failures, and project requirements determine what must run again.

Code and design questions receive direct answers. Explicit requirement changes update the affected decisions in an active workflow. After final handoff, a requested small follow-up can be implemented directly with its related checks; another workflow starts only when the user invokes it.

Each workflow ends after one independent review, finding assessment, repairs, and relevant checks, with a report for human review. Commits, pushes, and publication require a separate request. See [the shared workflow](references/workflow.md) for scope, continuation, and finding-disposition rules.

## Components and migration

Internal references use `task-flow:dispatch`, `task-flow:implementer`, and `task-flow:reviewer`. Standalone dispatch is also available as `/task-flow:dispatch`; it plans and delegates without adding the full task workflow's independent-review stage.

This plugin consolidates the former user-level `/dispatch` skill and `implementer` agent. After plugin validation and discovery, their old definitions are archived under `~/.claude/backups/task-flow-migration-<timestamp>/`. Maintain the definitions here. Existing sessions may retain old definitions until restarted.

## Validate

```sh
claude plugin validate ~/.claude/skills/task-flow
claude plugin details task-flow@skills-dir
```

Validation checks plugin structure; actual model routing, review invocation, approval continuation, and author resumption also need workflow smoke tests in an isolated project. The reviewer has inspection tools and instructions to remain read-only; its Bash access is not a separate shell sandbox.
