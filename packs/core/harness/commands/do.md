Turn a goal into done work via Blueprint Loop Engineering — without naming agents or skills.

1. Read and follow the **`do`** skill under the active runtime:
   - `.cursor/skills/do/SKILL.md`
   - `.claude/skills/do/SKILL.md`
   - `.agents/skills/do/SKILL.md`

2. Pass through the user’s outcome text as the initial request (everything after `/do`).

3. Do **not** skip requirement discovery (`grill-me`) or confirmation unless a confirmed Requirement Contract already matches the request.

4. Prefer existing pack skills selected by the Decision Engine; keep telemetry via `task-execution`.

Rules:
- User expresses outcomes, not implementation graphs.
- Safety-rules and HARNESS quality gates still apply.
- Escalate destructive / production / force operations.

<!-- managed-by: shared-agent-blueprints -->
