# Blueprint profiles

Profiles (also called blueprints) are the TUI choices when you run `blueprint install`. They share the same core harness and differ by **extra commands, skills, and templates**.

```text
default
├── engineering  (+ optional --overlay gitlab)
└── product
```

| Profile | Best for | Extra vs `default` |
|---|---|---|
| **`default`** | Any repo / general use | `/start`, `/review`, safety + task-execution rules, memory templates, base skills |
| **`engineering`** | Day-to-day coding + review/commit | Adds `/commit`, `refactor-code`, review prompt, ADR template; optional **GitLab** overlay (`/pr`, `/prerequisite`, `/fix-comment`, `/sync-dev`) |
| **`product`** | Early product / discovery work | Adds **PRD** + **ADR** templates; light branch defaults (`integration_branch: main`) |

Formerly named `startup` — use **`product`**. The CLI still accepts `startup` as an alias and rewrites it to `product` in state.

## Choosing at install

```bash
blueprint install default --runtime all --target /path/to/repo
blueprint install engineering --overlay gitlab --runtime all --target /path/to/repo
blueprint install product --runtime cursor --target /path/to/repo
```

Interactive TUI: pick target → **install** → blueprint → overlay → runtime → skill-mode.

Runtime (`cursor` / `claude` / `codex` / `all`) is **where** files are projected, not which profile content you get.

## Switching after you already installed

Re-running install with a different profile updates `.agent-blueprint.yaml` `blueprint:` and re-projects managed files.

```bash
# CLI
blueprint switch product --target /path/to/repo
# or re-install explicitly:
blueprint install engineering --runtime all --target /path/to/repo
```

Interactive TUI: choose **switch** (or run **install** again and pick another blueprint). Current runtimes / skill-mode from state are reused unless you change them.

Notes:

- Memory files (`PLANNING.md`, …) are not wiped.
- Profile-only extras from the old profile (e.g. `commit.md` from engineering, `prd.md` from product) may remain under the runtime until you remove them or run `blueprint del` + reinstall.
- `sync` / `update` keep the **current** profile from state; they do not ask you to switch.

## Related

- Pack sources: `packs/core/blueprints/`
- Setup flow: [agent-harness-blueprint docs/setup.md](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/setup.md)
