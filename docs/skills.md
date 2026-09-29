# Skills

Canonical inventory for skills under [`packs/core/harness/skills/`](../packs/core/harness/skills/). Edit here; bump `packs/core/pack.yaml` and [`catalog.yaml`](../catalog.yaml). Ownership: [architecture-split](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/architecture-split.md). Naming: [skill-naming](standards/skill-naming.md).

After `blueprint install`, skills project to `.cursor/skills/`, `.claude/skills/`, and/or `.agents/skills/`. Human-curated — load when the task matches.

**🟦** = original Blueprint skill (not vendored / adapted).

| Skill | Intent | Notes |
|-------|--------|-------|
| 🟦 `task-execution` | Sync each batch to `PLANNING.md` / `DECISIONS.md` / `RUN_LOG.md` (retain ~30 rows) | Use for audited execution, not casual Q&A |
| 🟦 `context-recall` | Layered memory vs chat: what belongs where, read order, promoting `LEARNING.md` | Memory model |
| 🟦 `refactor-code` | Simplify / dedupe while preserving behavior | Opt-in (`disable-model-invocation`). Order: `/ponytail-audit` → `/ponytail` → increments; prefer `/ponytail-review`. Companion: `test-strategy.md` |
| 🟦 `docs-style` | Thin root `README`, depth in `docs/`, richer `ARCHITECTURE.md` | Opt-in; docs IA refactors |
| `i-have-adhd` | ADHD-friendly output: next action first, numbered steps, no tangents | Opt-in; `/i-have-adhd` until `stop adhd mode`. [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) (MIT) |
| `ponytail` | YAGNI / minimal-code bias (`lite` \| `full` \| `ultra` \| `off`) | Required with `/refactor-code`. [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT) |
| `ponytail-review` | Over-engineering delete-list on current diff | Companion |
| `ponytail-audit` | Repo-wide over-engineering audit | Companion; run before `refactor-code` |
| `ponytail-debt` | Harvest deferred `ponytail:` shortcuts | Companion |
| `ponytail-gain` | Benchmark impact scoreboard | Companion |
| `ponytail-help` | Ponytail command quick reference | Companion |
| 🟦 `generate-test-cases` | Change → Testiny CSV under `.testiny/` | Opt-in; never auto-run |
| 🟦 `update-api-docs` | Sync FastAPI OpenAPI YAML + response examples with routers | Prefer `app.openapi()` re-export |
| 🟦 `skill-creator` | Author new skills (triggers, assets, eval loops) | Authoring infra, not coding policy |

## Wave 1 (mattpocock/skills, MIT)

Adapted — not Blueprint-original.

| Skill | Intent | Notes |
|-------|--------|-------|
| `practice-tdd` | Red → green TDD at agreed seams | Bundles: `tests.md`, `mocking.md`. Read `ARCHITECTURE.md` / ADRs when present |
| `diagnose-bugs` | Red loop → minimise → hypothesise → instrument → fix → regression-test | Bundle: `scripts/hitl-loop.template.sh` |
| `review-diff` | Standards + Spec review of `git diff <fixed-point>...HEAD` via sub-agents | Spec from `PLANNING.md` / path / PR; optional `/ponytail-review` |
| `design-modules` | Deep-module vocabulary (interface, depth, seam) | Complements `/ponytail`. Bundles: `DEEPENING.md`, `DESIGN-IT-TWICE.md` |
| `resolve-merge-conflicts` | Resolve merge/rebase conflicts by intent; finish unless user aborts | — |
| `research-topic` | Primary-source research → cited Markdown in-repo | — |
| `build-prototype` | Throwaway HTML/logic or toggleable UI to answer a design question | Bundles: `LOGIC.md`, `UI.md` |
| `teach-topic` | Multi-session tutoring workspace (`MISSION.md`, lessons, records) | Opt-in. Keep workspace out of harness memory files |
