# General

1. Use uv to manage Python environments and packages: `uv run` to execute, `uv add` to install; `pip install` and bare `python` are not used.

# Development workflow

Develop in a git worktree on a new branch named `<agent>/<topic>`, where `<agent>` is your own agent name in lowercase (`claude`, `codex`), unless the user explicitly asks to change files in the current directory.

- **Worktree (default)**: when done, rebase the branch onto the latest target branch, commit, push it, and open an MR on Gitea from that branch. The user reviews and merges the MR.
- **After the user says the MR is merged**: fast-forward the local target branch (usually `main`) to its latest remote state, then remove the worktree and delete its local branch.
- **Current directory (only when the user says so)**: work on the current local branch. Create no branch and make no commit unless asked.

# Gitea access

The Gitea server is at `$ALI_GITEA_URL`. Agents act as the bot account and use only the bot tokens; `ALI_GITEA_TOKEN` and `ALI_GITEA_READONLY_TOKEN` belong to the user and are off-limits.

- `ALI_GITEA_BOT_READONLY_TOKEN`: read-only access (clone, fetch, reading repos/MRs/issues through the API).
- `ALI_GITEA_BOT_TOKEN`: write access, for creating MRs and managing related permissions.

Use the read-only token unless the task requires writing.

Pass tokens through an HTTP header, e.g. `curl -H "Authorization: token $ALI_GITEA_BOT_TOKEN" "$ALI_GITEA_URL/api/v1/..."` or `git -c http.extraHeader="Authorization: token $ALI_GITEA_BOT_READONLY_TOKEN" clone ...`. Never embed a token in a remote URL, since git stores it in `.git/config`, and never print it or write it into files or commit messages.

# Rules about network

Ask the user before reading or changing this machine's network setup, and wait for approval. State the command and the reason.

- Changing: interfaces, routes, DNS (`/etc/resolv.conf`, `/etc/hosts`), firewall (`iptables`/`nftables`/`ufw`), proxy/VPN/TUN (Clash/mihomo, Tailscale), proxy env vars, network services.
- Reading: `ip`, `nmcli`, `ss`/`netstat`, `resolvectl`, routing tables, diagnostics (`ping`, `traceroute`, `dig`), proxy/VPN configs and subscriptions, public-IP lookups.

Ordinary network use (downloads, package installs, git, API calls) is outside this rule.

# Rules about questions on code

**Answer questions about code. Don't act on them.**

When the user asks about code ("can this be optimized for latency/memory?", "this looks complicated", "is there a better way?"), answer the question only - do not optimize, simplify, or refactor.

- Explain the tradeoffs, give a recommendation, show a snippet if helpful - but change nothing.
- To modify code, wait for an explicit request ("fix it", "do it", "apply it").

Exception: when asked whether something is a bug - if it is confirmed a bug AND the code was written in the current session, fix it directly.

# Rules about documentation and comments

State meaning and necessary constraints directly. Add negative or contrastive explanations (e.g. “不是”, “可以不”, “无需”) only when they prevent misuse that would cause errors or resolve ambiguity in context. For example, “Strategy names must be nonblank and unique” is sufficient.

# Rules about writing code

## 1. Named Constants, Not Magic Numbers

Meaningful values get a name, defined once and referenced everywhere:

```python
window_len = 14
df["ma"] = df["close"].rolling(window_len).mean()
```

- One place to change; the name documents intent.
- Not for self-evident literals (`0`, `1`, index arithmetic) or cosmetic one-offs.
- Comments describe the concept, never the value: `# stop-loss threshold`, not `# stop-loss at 2%`.

## 2. Core Logic vs. Peripheral Logic

**First classify the logic: core or peripheral.**

- *Core*: the behavior the component exists to provide — computation, data flow, its contract.
- *Peripheral*: transparency/visualization, logging, telemetry, metrics/latency exports, auto-resizing, cache warming, etc.

**Defaults may only control peripheral settings** (container capacity, thread count, log destination), never values that shape core results (e.g. the EMA lookback window) — the caller passes those explicitly.

**Unit-test core logic only.** Don't test peripheral side effects: asserting on them couples tests to implementation detail and adds brittleness. The exception is when the peripheral behavior is itself the feature under test (e.g. you were asked to implement the export format).
