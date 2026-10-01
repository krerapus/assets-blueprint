---
name: do
description: "User-facing outcome entry: turn a vague goal into a confirmed requirement, then run Blueprint's Loop Engineering workflow (discover → confirm → decide → execute → verify/review → quality gate → retry/replan/escalate → learn). Use when the user says /do or wants work done without naming agents/skills."
disable-model-invocation: true
---

# /do — Outcome entry (Loop Engineering)

## Purpose

Let the user state **what they want** without choosing agents, skills, graphs, or gates. This skill orchestrates existing Blueprint capabilities; it does **not** replace `task-execution`, memory files, or HARNESS quality gates.

## When to use

- User invokes `/do …` or the `do` command playbook.
- User wants an outcome but has not specified how to implement it.

## When not to use

- User already has a confirmed `PLANNING.md` checklist and asks only to execute → use `task-execution` directly.
- Pure Q&A with no repo work → answer normally; do not start the loop.

## Architecture (implemented)

```text
User → /do → grill-me (requirement discovery)
           → Requirement Contract in PLANNING.md
           → User confirmation
           → context-recall (orient)
           → Decision Engine (this skill + decision-engine.md)
           → Execute via mapped skills + task-execution
           → Verify / review-diff (and optional ponytail-review)
           → Quality Gate (HARNESS + contracts.md)
           → next action: FIX | RETRY | REPLAN | WAIT | ESCALATE | COMPLETE
           → LEARNING / DECISIONS / RUN_LOG
```

Companions (read when needed):

| File | Role |
|---|---|
| [requirement-contract.md](requirement-contract.md) | Contract schema ↔ `PLANNING.md` |
| [decision-engine.md](decision-engine.md) | Hybrid reasoner + policy; action vocabulary |
| [loop-states.md](loop-states.md) | Lifecycle + resumability via `HOTCACHE.md` |
| [contracts.md](contracts.md) | Agent / Subagent / Quality Gate contracts |

Full narrative: [`docs/loop-engineering.md`](../../../../../docs/loop-engineering.md) (pack docs).

## Workflow (in order)

### 1. Orient

- Read `HARNESS.md` Skill use cases, `AGENTS.md`, then apply `context-recall` read order.
- Load Loop state from `HOTCACHE.md` (see [loop-states.md](loop-states.md)). If a resumable loop exists for this goal, offer resume instead of restarting discovery.

### 2. Requirement discovery (`grill-me`)

- If the request is already a confirmed contract (`status: confirmed` in PLANNING Requirement Contract) and the user did not change intent → skip to step 4.
- Otherwise follow **`grill-me`**: minimum questions until stop conditions pass.
- Write / update the **Requirement Contract** section in `PLANNING.md` ([requirement-contract.md](requirement-contract.md)).
- Set HOTCACHE Loop state → `REQUIREMENT_DISCOVERY` then `AWAITING_CONFIRMATION`.

### 3. Human confirmation checkpoint

Present a concise summary (not the full YAML):

```text
Here's what I understand:

Goal:
…

Scope (in / out):
…

Constraints:
…

Acceptance criteria:
…

Assumptions / unresolved (accepted?):
…

Ready to start?
```

- **No** → update contract via `grill-me`; do not execute.
- **Yes** → set contract `status: confirmed`, HOTCACHE → `PLANNING`, proceed.
- Never execute against a stale or `draft` contract after the user changed intent.

### 4. Decision Engine (plan capabilities)

Follow [decision-engine.md](decision-engine.md):

1. **Policy** (deterministic): safety, authority, offline/destructive gates, retry limits, required reviews.
2. **Reasoning** (LLM): classify task, pick strategy, map to **capabilities** → existing skills (not invent new agents).
3. Emit a short plan into `PLANNING.md` Task checkboxes + HOTCACHE Working Assumptions.
4. Record non-obvious choices in `DECISIONS.md`.

Default capability map (select only what is needed):

| Need | Skill / command |
|---|---|
| Batch execute + telemetry | `task-execution` |
| Memory orientation | `context-recall` |
| TDD | `practice-tdd` |
| Hard bug | `diagnose-bugs` |
| Design seams | `design-modules` |
| Research | `research-topic` |
| Prototype | `build-prototype` |
| Refactor / simplify | `refactor-code` + `ponytail` (+ audit when required) |
| Spec/standards review | `review-diff` |
| Over-engineering pass | `ponytail-review` (non-trivial only) |
| Docs / OpenAPI | `docs-style` / `update-api-docs` |
| Merge conflicts | `resolve-merge-conflicts` |

**Ponytail** is a cross-cutting constraint: prefer simpler plans; do not mandate `ponytail-review` for trivial edits.

### 5. Execute

- HOTCACHE → `EXECUTING`.
- Implement via selected skills; keep batches small.
- After each batch, run **`task-execution`** checklist (PLANNING / DECISIONS / RUN_LOG).

### 6. Verify + review (independent where practical)

- HOTCACHE → `VERIFYING` / `REVIEWING`.
- Run tests / checks implied by acceptance criteria.
- Prefer `review-diff` (Standards + Spec from PLANNING) after meaningful diffs.
- Optionally `ponytail-review` when the Decision Engine marked complexity risk.
- Implementation agent should not “grade its own homework” alone when a second review pass is warranted — use sub-agent style reviews as in `review-diff`.

### 7. Quality Gate

- HOTCACHE → `QUALITY_GATE`.
- Evaluate using HARNESS Quality gates + [contracts.md](contracts.md) `GateResult` shape (`PASS` | `FAIL` | `CONDITIONAL`).
- Gate answers “good enough?” — Decision Engine answers “what next?”

### 8. Next action

| Action | Meaning | Transition |
|---|---|---|
| `COMPLETE` | Gate PASS; acceptance met | → `COMPLETED` → learn |
| `FIX` | Blocker finding; plan still valid | → `EXECUTING` |
| `RETRY` | Transient / execution failure; same plan | → `EXECUTING` (count retry) |
| `REPLAN` | Plan invalid | → `PLANNING` (new checkboxes) |
| `WAIT` | External dependency | → `WAITING`; document blocker |
| `ESCALATE` | Outside authority / unsafe / ambiguous | → `HUMAN`; stop |

Retry vs replan vs escalate: [decision-engine.md](decision-engine.md) + [loop-states.md](loop-states.md).

### 9. Learn / persist

- HOTCACHE → `LEARNED` / clear Active Loop when done.
- Append `DECISIONS.md` / `RUN_LOG.md` via `task-execution`.
- Candidate insights → `LEARNING.md` (do not auto-promote to skills).

## User experience rules

- Keep internal graph/agents invisible unless the user asks.
- Ask the **minimum** questions (`grill-me` + ponytail).
- Prefer existing skills over new abstractions.
- Destructive / production / force operations → **ESCALATE** (safety-rules).

## Validation scenarios (manual)

Agents following this skill should behave correctly for:

1. Clear simple task → short confirm → minimal skills → COMPLETE  
2. Vague task → grill-me questions → confirm → execute  
3. User changes requirement mid-discovery → update contract → re-confirm  
4. Implementation failure → RETRY (same plan)  
5. Plan wrong → REPLAN  
6. Review blocker → FIX  
7. Review pass → COMPLETE  
8. Destructive ask → ESCALATE  
9. Waiting on CI/human → WAIT  
10. Trivial typo/docs → skip heavy review / ponytail-review  
