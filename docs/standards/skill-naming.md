# Skill naming standard

Normative rules for skills under [`packs/core/harness/skills/`](../../packs/core/harness/skills/). Agents and humans MUST follow this when creating or renaming skills. Edit the pack here — the CLI may keep a legacy mirror under `agent-harness-blueprint/harness/skills/` (fallback only). See [architecture-split](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/architecture-split.md).

## Purpose

Keep Skill identity minimal, capability-based, and reusable across Agents, models, and runtimes.

## Core principle

| Concern | Question | Belongs in Skill name? |
|---|---|---|
| Skill | WHAT capability exists? | YES |
| Agent | WHO uses it? | NO |
| Workflow | HOW is it orchestrated? | NO |
| Model | WITH WHICH model? | NO |
| Runtime / client | WHERE does it run? | NO |

## Naming format

Every Skill `name` (and directory name) MUST follow:

```text
<action>-<object>[-<context>]
```

Requirements:

- MUST be lowercase
- MUST use hyphen (`-`) as the only separator
- MUST be machine-friendly and describe a capability
- SHOULD be ≤ 40 characters
- SHOULD prefer canonical action vocabulary (below)
- Directory name MUST match SKILL.md frontmatter `name`

### Canonical action vocabulary

Prefer these prefixes when applicable:

- Analysis: `analyze-`, `inspect-`, `investigate-`
- Generation: `generate-`, `create-` (only when `generate-` is wrong semantically)
- Validation: `check-`, `validate-`, `verify-`
- Transformation: `convert-`, `transform-`, `migrate-`, `refactor-`
- Operations: `deploy-`, `release-`, `publish-`, `sync-`, `backup-`, `update-`

Do NOT invent synonyms for the same capability (`analyze-jira` vs `jira-analysis` vs `jira-analyzer`). Prefer **action-first**.

## Forbidden patterns

Skill names MUST NOT include:

- Agent / engineer roles (`backend-engineer-`, `qa-`, `senior-`, `architect-`)
- Model / provider / client (`gpt-`, `claude-`, `gemini-`, `cursor-`, `copilot-`, `llm-`)
- Version / channel (`-v1`, `-v2`, `-beta`, `-legacy`, `-new`)
- Redundant suffixes (`-skill`, `-agent`, `-assistant`, `-tool`, `-service`)
- Vague tokens (`helper`, `utility`, `common`, `misc`, `general`, `processor`, `manager`)

## Skill identity (frontmatter)

```yaml
---
name: generate-test-cases
description: Generate structured test cases from requirements and acceptance criteria.
---
```

- `name` is the canonical immutable identifier (unless a deliberate rename + `harness/migrations/renames.log` entry).
- Optional human label may live in the H1 title; do not put display-only branding in `name`.
- Implementation details belong in description, body, inputs, and workflow—not the name.

## Naming quality gate

Before registering a skill, confirm YES to:

1. Describes WHAT the skill does?
2. Starts with a clear action?
3. Object / domain clear?
4. Lowercase + hyphens only?
5. Concise (ideally ≤ 40 chars)?
6. No role / model / client / version / redundant suffix / vague token?
7. Reusable by another Agent if the model changes?

Reject the name if any major architectural rule fails.

## Examples

| Bad | Good | Reason |
|---|---|---|
| `backend-engineer-code-review` | `review-code` | Role is not Skill identity |
| `qa-test-generator` | `generate-test-cases` | Capability-based, action-first |
| `gpt-code-review` | `review-code` | Model-independent |
| `jira-analyzer-agent` | `analyze-jira-ticket` | No `-agent` suffix; action-first |
| `code-review-v2` | `review-code` | No version in name |
| `code-review-skill` | `review-code` | Redundant suffix |
| `testcase-generator` | `generate-test-cases` | Prefer action-first |

## Package exceptions (grandfathered)

These existing package skills are **vendored or established identities**. Do NOT rename them for style alone; new skills MUST still follow this standard:

| Name | Reason |
|---|---|
| `ponytail`, `ponytail-*` | Vendored brand / command surface |
| `i-have-adhd` | Vendored brand |
| `skill-creator` | Meta authoring infrastructure |
| `context-recall`, `task-execution`, `docs-style` | Established harness protocol names |

When introducing a **new** skill that overlaps a grandfathered capability, prefer a standards-compliant action-first name rather than extending the exception list.

## Repository process

1. Draft the skill with `skill-creator` in this repo.
2. Pass this naming gate (and CLI [contributor-standards](https://github.com/krerapus/agent-harness-blueprint/blob/master/contributor/rules/contributor-standards.mdc) when editing from a CLI checkout).
3. Register only after the name and draft meet standards (`packs/core/manifest.yaml`, this inventory, blueprint inventories).
4. On rename: append `skill  old_name  new_name` to [`packs/core/harness/migrations/renames.log`](../../packs/core/harness/migrations/renames.log) and update all inventories.

See also: [`skills.md`](../skills.md), [`CONTRIBUTING.md`](../../CONTRIBUTING.md).
