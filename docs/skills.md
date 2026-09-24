# Skills

Canonical inventory for skills under [`packs/core/harness/skills/`](../packs/core/harness/skills/). Edit skills here; bump `packs/core/pack.yaml` and root [`catalog.yaml`](../catalog.yaml). The CLI may keep a legacy mirror under `agent-harness-blueprint/harness/skills/` as fallback only — see [architecture-split](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/architecture-split.md).

After `blueprint install`, the same folders appear under the consumer's `.cursor/skills/`, `.claude/skills/`, and/or `.agents/skills/` as `SKILL.md` plus optional bundles. They are **human-curated** procedures—load them when the task matches their scope.

Naming gate: [standards/skill-naming.md](standards/skill-naming.md).

## `task-execution`

**Intent:** Tie each implementation batch back to observable artifacts in the **adopting project**:

- reconcile `PLANNING.md` checkboxes / `## ✅ Done`,
- append a succinct `DECISIONS.md` line (did / why),
- append one capped `RUN_LOG.md` telemetry row,
- enforce RUN_LOG retention (keep ~30 freshest rows beneath the header).

Use whenever execution must leave audit breadcrumbs—not casual Q&A.

## `context-recall`

**Intent:** Define *how layered memory behaves* versus chat history:

- what belongs in telemetry vs rationale vs drafts,
- which layers to read before executing,
- how humans promote `LEARNING.md` ideas into curated skills/rules.

## `refactor-code` (+ `test-strategy.md`)

**Intent:** Opinionated simplification playbook—flatten complexity, extract duplication thoughtfully, preserve behavior (any programming language). Ships with **`disable-model-invocation`** so tooling does not auto-load it—invoke deliberately when refactoring.

**Required order:** (1) run `/ponytail-audit` first to discover over-engineering, (2) enable `/ponytail` (see HARNESS skill use cases), then propose increments. Prefer `/ponytail-review` on the resulting diff. Companion **test-strategy** lays out regression priorities and safety rails. The workflow expects humans to apply risky edits/tests while the assistant analyzes and proposes increments.

## `docs-style`

**Intent:** Opinionated docs layout—thin root `README`, deeper material inside `docs/` plus guidance for richer `ARCHITECTURE.md` write-ups (Mermaid, lifecycle fidelity). Also `disable-model-invocation`; use when refactoring documentation IA.

## `i-have-adhd`

**Intent:** ADHD-friendly agent output — lead with the next action, number multi-step work, restate state each turn, suppress tangents, concrete time estimates, no preamble/closers. Invoke with `/i-have-adhd`; stays on until `stop adhd mode`.

Vendored from [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT). Ships with `disable-model-invocation`.

## `ponytail` (+ review / audit / debt / gain / help)

**Intent:** Minimal-code bias — YAGNI ladder before writing (skip / reuse / stdlib / native / dependency / one line / minimum). Default intensity `full`; switch with `/ponytail lite|full|ultra|off`. Companion skills:

- `ponytail-review` — delete-list for over-engineering in the current diff
- `ponytail-audit` — repo-wide over-engineering audit
- `ponytail-debt` — harvest deferred `ponytail:` shortcuts
- `ponytail-gain` — benchmark impact scoreboard reference
- `ponytail-help` — command quick reference

Vendored from [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT).

**Required with `refactor-code`:** invoking `/refactor-code` must also enable `/ponytail` for that session.

## `generate-test-cases`

**Intent:** Senior-QA playbook that analyzes a software change (JIRA / branch / PR / `PLANNING.md`) and writes a Testiny-importable CSV to `.testiny/testcases-<JIRA>.csv` (gitignored). Ships with `disable-model-invocation` — invoke explicitly (`/generate-test-cases`). Schema and column rules live in the skill markdown (no bundled CSV). Opt-in only; never auto-run for ordinary coding work.

## `update-api-docs`

**Intent:** Keep FastAPI OpenAPI YAML (`docs/api/openapi.yaml`) and response example JSON files in sync with `app/routers/`. Prefer re-export via `app.openapi()`; fall back to manual path/schema/example edits. Use when adding, removing, or changing API endpoints, refreshing swagger/OpenAPI, or updating response examples.

## `skill-creator`

**Intent:** Meta-playbook for authoring new skills:

- interviewing intent/trigger phrases,
- bundling supplementary assets,
- qualitative + quantitative evaluation loops,
- tightening descriptions (“slightly pushy” wording) so retrieval triggers reliably.

Treat it as **authoring infrastructure**, not coding policy baked into builds.

## Wave 1 (adapted from mattpocock/skills, MIT)

### `practice-tdd` (+ `tests.md`, `mocking.md`)

**Intent:** Red → green TDD at pre-agreed seams. Read `ARCHITECTURE.md` / ADRs for domain vocabulary when present.

### `diagnose-bugs` (+ `scripts/hitl-loop.template.sh`)

**Intent:** Hard-bug diagnosis: build a red feedback loop → minimise → hypothesise → instrument → fix → regression-test.

### `review-diff`

**Intent:** Two-axis review (Standards + Spec) of `git diff <fixed-point>...HEAD` via parallel sub-agents. Spec prefers `PLANNING.md` / user path / PR. Optional follow-up: `/ponytail-review`.

### `design-modules` (+ `DEEPENING.md`, `DESIGN-IT-TWICE.md`)

**Intent:** Deep-module vocabulary (module, interface, depth, seam, adapter). Complements `/ponytail` rather than replacing it.

### `resolve-merge-conflicts`

**Intent:** Resolve in-progress merge/rebase conflicts hunk by hunk by intent; finish the operation unless the user asks to abort.

### `research-topic`

**Intent:** Investigate against primary sources; write cited Markdown findings into the repo.

### `build-prototype` (+ `LOGIC.md`, `UI.md`)

**Intent:** Throwaway HTML/logic or toggleable UI prototypes to answer a design question before production code.

### `teach-topic` (+ mission/lesson format docs)

**Intent:** Multi-session tutoring in a stateful teaching workspace (`MISSION.md`, `lessons/*.html`, `learning-records/`, `RESOURCES.md`). Ships with **`disable-model-invocation`**. Adapted from Matt Pocock `productivity/teach` (MIT). Keep the workspace out of harness memory files.
