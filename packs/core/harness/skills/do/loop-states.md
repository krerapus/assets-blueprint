# Loop Engineering states

Lifecycle for `/do`. Resumable via consumer **`HOTCACHE.md`** (not a new memory file).

## HOTCACHE Loop block

Keep under Active State or a dedicated section:

```markdown
## Loop
- State: AWAITING_CONFIRMATION
- Req: REQ-notify-2026-10-01
- Retry: 0
- Last action: PLAN
- Blocker: -
```

Replace on each transition; do not append endlessly (`context-recall` discipline).

## State machine (implemented)

```text
QUEUED
  → REQUIREMENT_DISCOVERY      # grill-me
  → AWAITING_CONFIRMATION      # /do summary
  → PLANNING                   # Decision Engine PLAN
  → PLAN_READY
  → EXECUTING
  → VERIFYING
  → REVIEWING
  → QUALITY_GATE
       ├─ PASS     → COMPLETED → LEARNED
       ├─ FIX      → EXECUTING
       ├─ RETRY    → EXECUTING
       ├─ REPLAN   → PLANNING
       ├─ WAIT     → WAITING
       └─ ESCALATE → HUMAN
```

## Resumability

1. On `/do` start, read HOTCACHE Loop.  
2. If `State` is `WAITING`, `HUMAN`, `EXECUTING`, `QUALITY_GATE`, etc. for the same `Req`, offer **resume** at that node.  
3. Do not re-grill a `confirmed` contract unless the user changes intent.  
4. `LEARNED` / cleared Loop = finished; next `/do` starts fresh.

## Graph properties (procedural, not a workflow engine)

| Property | How Blueprint realizes it |
|---|---|
| Sequential | Ordered `/do` workflow steps |
| Parallel | `review-diff` Standards/Spec sub-agents; optional parallel checks |
| Conditional | Decision Engine SKIP / capability selection |
| Retry / loop | RETRY / FIX / REPLAN actions + Retry counter |
| Skip | Trivial-task policy skips heavy review |
| Failure | Gate FAIL → FIX/REPLAN/ESCALATE |
| Escalation | `HUMAN` state + user prompt |
| Resumability | HOTCACHE Loop + PLANNING checkboxes |

There is **no** separate workflow-engine binary — the Decision Engine procedure chooses the next node.
