# Requirement Contract

Structured representation of confirmed (or draft) user intent for `/do`.

**Storage:** section inside consumer `PLANNING.md` — not a separate memory file. Adapts Blueprint’s planning SoT instead of Matt-style `CONTEXT.md` / issue trackers.

## Schema

```yaml
# PLANNING.md → ## Requirement Contract
id: REQ-<short>          # e.g. REQ-notify-2026-10-01
status: draft | confirmed

objective: "What the user ultimately wants"
problem: "Why this work is needed"

scope:
  in:
    - ...
  out:
    - ...

requirements:
  - ...

constraints:
  - ...

acceptance_criteria:
  - ...

assumptions:
  - ...

unresolved:
  - ...                 # must be empty or explicitly accepted before confirm
```

## Mapping to existing Blueprint fields

| Contract field | Blueprint file / section |
|---|---|
| `objective` | `PLANNING.md` `## Goal` |
| `scope` / `requirements` / AC | `PLANNING.md` `## Task` (after confirm) + optional PRD template |
| Tradeoffs during discovery | `DECISIONS.md` (only when a real choice was made) |
| Loop phase | `HOTCACHE.md` Loop state |
| Stable architecture impact | `ARCHITECTURE.md` / ADR — only if design changes |

## Status rules

- `draft` — discovery or user edit in progress; **no execution**.
- `confirmed` — user accepted the confirmation summary in `/do`.
- Any material change to objective/scope/AC → set back to `draft` and re-confirm.

## Example (compact Markdown form allowed)

Agents may render the contract as YAML **or** equivalent Markdown headings under `## Requirement Contract`, as long as all fields above are present.
