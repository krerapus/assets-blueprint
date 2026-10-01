# Decision Engine

Hybrid controller used by `/do` after a **confirmed** Requirement Contract.

> Answers: **What should happen next?**  
> Does **not** replace the Quality Gate (“Is this good enough?”).

Implemented as **procedure in the `do` skill** (no separate runtime binary). Extends existing Blueprint planning — does not invent a second orchestrator product.

## Inputs

- Confirmed Requirement Contract (`PLANNING.md`)
- Project context (`AGENTS.md`, `ARCHITECTURE.md`, ADRs)
- Memory (`HOTCACHE`, recent `DECISIONS` / `LEARNING` via `context-recall`)
- Repository state (diff, tests, CI if available)
- Available capabilities (HARNESS Skill use cases)
- Policies (`safety-rules`, HARNESS Quality gates, authority below)

## Abstraction

```text
Decision → Capability → (existing) Skill / Command
                 ↘ optional Subagent review pass
```

Do **not** jump straight from Decision → named persona agent. Prefer selecting **capabilities** that map to pack skills.

## Hybrid split

### Reasoning (LLM)

- Classify task (trivial / feature / refactor / bug / research / docs)
- Draft plan steps and acceptance mapping
- Choose strategy (TDD vs spike vs direct fix)
- Interpret review findings
- Propose FIX vs RETRY vs REPLAN vs ESCALATE (subject to policy)

### Policy (deterministic — always wins)

- Safety-rules / destructive ops → **ESCALATE** or require explicit user confirmation
- Authority: no merge/deploy/force-push unless user explicitly requests and policy allows
- Retry limit: default **max 2** `RETRY` on the same plan step, then **REPLAN** or **ESCALATE**
- Trivial tasks: skip `ponytail-review` and multi-subagent review unless user asks
- Non-trivial code changes: prefer at least one of tests / `review-diff` before COMPLETE
- `refactor-code` ⇒ must follow HARNESS order (`ponytail-audit` then `ponytail`)
- Offline / missing tools: degrade capability list; do not invent fake green checks
- Completion requires HARNESS completion criteria + contract acceptance criteria

## Action vocabulary

| Action | Use when |
|---|---|
| `PLAN` | Build/refresh Task checkboxes from contract |
| `EXECUTE` | Run next planned capability batch |
| `REVIEW` | Invoke review capabilities (`review-diff`, optional `ponytail-review`) |
| `VERIFY` | Run tests / doctor / acceptance checks |
| `RETRY` | Same plan; transient or fixable execution failure |
| `REPLAN` | Plan invalid or acceptance unreachable as scoped |
| `FIX` | Gate/review blocker; plan still valid |
| `SKIP` | Capability unnecessary for this classification |
| `WAIT` | Blocked on CI, human, or external system |
| `ESCALATE` | Ambiguity, authority, safety, or conflicting requirements |
| `COMPLETE` | Gate PASS + AC met |

## Failure semantics

| Kind | Meaning | Next |
|---|---|---|
| **RETRY** | Plan valid; attempt failed | Re-run same step; increment retry |
| **REPLAN** | Plan insufficient | New PLANNING checkboxes; reset retry |
| **ESCALATE** | Cannot safely decide | Stop; ask human; HOTCACHE `HUMAN` |
| **WAIT** | External condition | Document blocker; HOTCACHE `WAITING` |

## Outputs

1. Updated `PLANNING.md` Task list  
2. HOTCACHE assumptions + Loop state  
3. Optional `DECISIONS.md` row for non-obvious capability choices  
4. Explicit next action from the vocabulary above  
