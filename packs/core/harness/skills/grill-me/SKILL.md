---
name: grill-me
description: "Requirement discovery: ask the minimum questions needed to make a vague goal executable, then write a Requirement Contract into PLANNING.md. Used by /do before planning or execution. Use when clarifying scope, constraints, and acceptance criteria."
disable-model-invocation: true
---

# grill-me — Requirement discovery

## Purpose

Turn ambiguous human intent into a **Requirement Contract** living in `PLANNING.md`, with enough clarity to execute safely — and **no more questions than necessary**.

This is an **internal** discovery mechanism. Users normally enter via `/do`; invoke `grill-me` directly only when refining requirements without starting full execution.

## Relationship to `/do`

```text
/do
  └── Requirement Discovery
        └── grill-me  →  PLANNING.md Requirement Contract
              └── user confirmation (owned by /do)
```

## When to use

- `/do` step 2 (default path for vague outcomes).
- User asks to clarify / grill a goal before implementation.
- Contract exists but `unresolved` or `status: draft` blocks safe execution.

## When not to use

- Contract already `confirmed` and intent unchanged.
- User only wants brainstorming with no execution intent.
- Endless interview would violate ponytail / minimalism — stop when stop conditions pass.

## Stop conditions (all should be true, or explicitly accepted)

| Flag | Meaning |
|---|---|
| `objective_clear` | One-sentence outcome is unambiguous |
| `scope_clear` | In-scope and out-of-scope listed |
| `constraints_known` | Hard constraints known or “none” stated |
| `acceptance_criteria_defined` | Testable checks exist |
| `major_ambiguities_resolved` | No blocking “either/or” left open |
| `unresolved_risks_accepted` | Remaining risks listed and user accepts them |

If a flag fails, ask **one focused question** (or a tight multiple-choice), update the contract, re-check. Prefer batches of ≤3 questions when several gaps are independent.

## Output: Requirement Contract

Write or update a section in **`PLANNING.md`** (not a new root memory file). Schema: [`do/requirement-contract.md`](../do/requirement-contract.md).

Also set:

- `PLANNING.md` `## Goal` from `objective`
- Draft `## Task` checkboxes only after `/do` confirmation (discovery should not pretend execution started)
- `HOTCACHE.md` Focus line = objective; Loop state `REQUIREMENT_DISCOVERY`

## Question style

- Prefer concrete choices over open essays.
- Do not ask for agent/skill/model selection — `/do` owns that.
- Do not ask for full architecture up front; stop at executable clarity.
- If the user pastes a rich brief that already satisfies stop conditions, **confirm summary once** and skip further grilling.

## After discovery

Hand back to `/do` for the confirmation checkpoint. Do not start implementation from `grill-me` alone unless the user explicitly asks to execute after confirming.
