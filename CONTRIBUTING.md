# Contributing

Thanks for helping improve **assets-blueprint**. This repository holds independently versioned static packs consumed by the [Blueprint CLI](https://github.com/krerapus/agent-harness-blueprint).

## Development setup

Requirements: Bash, Git, and a Unix-like shell (macOS / Linux). The Blueprint CLI is needed to exercise packs end-to-end.

```bash
git clone https://github.com/krerapus/assets-blueprint.git
cd assets-blueprint

# Prefer a sibling CLI checkout:
#   ../agent-harness-blueprint
export BLUEPRINT_ASSETS_ROOT="$(pwd)"
```

Orientation:

1. [README.md](README.md) — how packs flow into the CLI
2. [`catalog.yaml`](catalog.yaml) — published pack versions
3. `packs/<name>/pack.yaml` — per-pack semver and `cli_compat`
4. [docs/skills.md](docs/skills.md) — skill inventory
5. [docs/standards/skill-naming.md](docs/standards/skill-naming.md) — required naming gate before new skills

## How this repo works

Packs under `packs/` are packaged into GitHub Release assets. The CLI installs them into its cache and projects content into consumer projects. This repo does **not** ship the CLI binary or Homebrew Formula.

See the Mermaid diagrams in [README.md](README.md#how-it-works).

## Branch naming

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<short-slug>` | `feature/core-new-skill` |
| Bug fix | `fix/<short-slug>` or `hotfix/<short-slug>` | `fix/catalog-asset-name` |
| Docs | `docs/<short-slug>` | `docs/contributing` |
| Chore | `chore/<short-slug>` | `chore/pack-gitignore` |

Use lowercase kebab-case slugs.

## Commit convention

Prefer conventional commits: `type(scope): description` with types `feat|fix|refactor|test|docs|chore`.

Examples:

- `feat(core): add refactor-code skill notes`
- `docs: clarify pack release tags`
- `chore(catalog): bump core to 1.5.0`

Keep commits focused. Do not commit `dist/` tarballs or consumer runtime trees (`.cursor/`, `.claude/`, `.agents/`).

## Pull request process

1. Branch from the default branch with a focused change.
2. If you change pack contents that ship to users, bump `packs/<name>/pack.yaml` and [`catalog.yaml`](catalog.yaml) in the same PR (or document why a bump is deferred).
3. Run a local package smoke check: `./scripts/package-pack.sh <name>`.
4. Open a PR describing **why** the change exists and how you verified it.
5. Keep the PR scoped — pack content, catalog, and docs in one PR is fine; unrelated CLI Formula edits belong elsewhere.

## How to update source

Checklist for a pack release:

1. Edit under `packs/<name>/`.
2. Bump `version` in `packs/<name>/pack.yaml` (update `cli_compat` when required).
3. Sync [`catalog.yaml`](catalog.yaml) (`version`, `release_asset`, `cli_compat`).
4. `./scripts/package-pack.sh <name>` — confirm `dist/<name>-v<ver>.tar.gz` (+ `.sha256`).
5. Merge the PR, then push tag `<name>-v<ver>` (e.g. `core-v1.5.0`), or use the **Assets Release** workflow `workflow_dispatch`.
6. Confirm the GitHub Release attaches the tarball and checksum.
7. From a CLI install: `blueprint assets update <name>` (or clear cache and `install`) and smoke-test projection.

## Skills

Before adding or substantially rewriting a skill under `packs/core/harness/skills/`:

1. Use `/skill-creator` (or follow that skill’s playbook).
2. Pass [docs/standards/skill-naming.md](docs/standards/skill-naming.md).
3. Update [docs/skills.md](docs/skills.md) and `packs/core/manifest.yaml` in the same PR when the inventory changes.

## Testing / review expectations

- `pack.yaml` and `catalog.yaml` stay in sync for any version bump
- Release asset names match `catalog.yaml` `release_asset`
- No placeholder or invented checksums in docs or release notes
- Prefer composition inside packs over forking entire profiles
- Clarity and backward-compatible pack defaults unless the PR documents a break
- New skills follow the naming standard and appear in `docs/skills.md`

Questions welcome via GitHub Issues.
