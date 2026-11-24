# Development workflow

Develop in a git worktree on a new branch named `<agent>/<topic>`, where `<agent>` is your own agent name in lowercase (`claude`, `codex`), unless the user explicitly asks to change files in the current directory.

- **Worktree (default)**: when done, rebase the branch onto the latest target branch, commit, push it, and open an MR on Gitea from that branch. The user reviews and merges the MR.
- **After the user says the MR is merged**: fast-forward the local target branch (usually `main`) to its latest remote state, then remove the worktree and delete its local branch.
- **Current directory (only when the user says so)**: work on the current local branch. Create no branch and make no commit unless asked.
