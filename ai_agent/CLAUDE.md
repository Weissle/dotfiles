# General

1. Use uv to manage Python environments and packages.

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
