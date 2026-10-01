# Agent, Subagent, and Quality Gate contracts

Lightweight contracts for `/do`. They **document authority boundaries**; they do not add a new agent runtime. Project agent contract remains `AGENTS.md` + `HARNESS.md`.

## Agent contract (outcome owner)

An **Agent** (the primary coding session following `/do`) owns delivery of the confirmed Requirement Contract within authority limits.

```yaml
AgentContract:
  id: primary-session
  version: 1
  purpose: "Deliver the confirmed Requirement Contract via selected capabilities"
  capabilities:
    - execute-code-changes
    - run-tests
    - update-memory-files
    - invoke-pack-skills
  inputs:
    required: [requirement_contract, planning]
    optional: [architecture, adrs, hotcache]
  outputs: [code_diff, tests, planning_updates, decisions, run_log]
  authority:
    can_modify_code: true
    can_modify_tests: true
    can_modify_docs: true
    can_change_plan: true   # only via REPLAN after Decision Engine
    can_merge: false
    can_deploy: false
  constraints:
    - Follow safety-rules and HARNESS precedence
    - Prefer existing pack skills over ad-hoc process
  quality_requirements:
    - HARNESS Quality gates
    - Contract acceptance_criteria
  escalation_triggers:
    - Destructive / production operations
    - Authority boundary (merge, deploy, secrets)
    - Unresolvable requirement conflict
```

## Subagent contract (bounded specialist)

A **Subagent** provides analysis or verification with **narrow scope**. It should not own the main outcome or silently mutate Loop state (the primary session applies results).

```yaml
SubagentContract:
  id: standards-reviewer   # example; also: spec-reviewer, complexity-reviewer, …
  version: 1
  role: "Bounded review or investigation"
  input: "Diff and/or spec excerpt"
  output: "Findings list with severity"
  scope: "Read-focused; no drive-by refactors"
  authority:
    can_modify_code: false
    can_modify_state: false
    can_approve: false
  limits:
    max_scope: "single review axis or investigation thread"
    max_attempts: 1
```

Typical Blueprint mappings:

| Subagent role | Existing skill / mechanism |
|---|---|
| Standards reviewer | `review-diff` Standards axis |
| Spec reviewer | `review-diff` Spec axis |
| Complexity reviewer | `ponytail-review` |
| Bug investigator | `diagnose-bugs` |
| Test writer | `practice-tdd` / `generate-test-cases` (opt-in) |

## Quality Gate contract

Separate from Decision Engine.

```yaml
QualityGateContract:
  id: harness-default
  version: 1
  inputs:
    - acceptance_criteria
    - implementation_diff
    - tests_or_checks
    - review_findings
  rules:
    - HARNESS Quality gates / Completion criteria
    - Contract acceptance_criteria must be evidenced
  severity_policy:
    blocker: fail
    critical: fail unless user explicitly accepts
    warning: pass with note
  pass_conditions:
    - No open blockers
    - Acceptance criteria evidenced or explicitly waived
  fail_conditions:
    - Blocker finding
    - Required verify step skipped on non-trivial change
```

### GateResult (do not collapse to bool)

```yaml
GateResult:
  status: PASS | FAIL | CONDITIONAL
  findings:
    - severity: blocker | critical | warning
      category: correctness | regression | complexity | safety | spec
      description: "..."
      evidence: "..."
  evidence:
    tests: "..."
    reviews: "..."
    checks: "..."
  confidence: low | medium | high
```

- `PASS` → Decision Engine may `COMPLETE`  
- `FAIL` → `FIX` / `REPLAN` / `ESCALATE`  
- `CONDITIONAL` → proceed only with documented warnings + user awareness when required  
