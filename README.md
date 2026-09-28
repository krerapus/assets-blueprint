# assets-blueprint

Independently versioned static packs for the [Blueprint CLI](https://github.com/krerapus/agent-harness-blueprint).

**This repo is the source of truth for harness content** (skills, profiles, standards, templates). The CLI downloads or mounts packs; it does not own pack versioning.

Sibling repos: [`agent-harness-blueprint`](https://github.com/krerapus/agent-harness-blueprint) (CLI + docs) · [`homebrew-blueprint`](https://github.com/krerapus/homebrew-blueprint) (Formula).

Three-repo ownership: [architecture-split.md](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/architecture-split.md).

```text
assets-blueprint  →  packs via `blueprint assets install`
agent-harness-blueprint  →  CLI release → homebrew-blueprint Formula
CLI  →  `install` / `update` / `sync`  →  consumer project
```

## How to use

### As a Blueprint user

```bash
blueprint assets list
blueprint assets install core
blueprint assets update core
blueprint assets doctor --offline
```

The CLI fetches from GitHub Releases listed in `catalog.yaml` (cached under `~/.cache/blueprint/assets/`).

### Local development (sibling checkout)

```bash
export BLUEPRINT_ASSETS_ROOT="$(pwd)"   # or auto-detect ../assets-blueprint from a CLI checkout
blueprint assets list
blueprint assets install core
blueprint assets doctor
```

## How to update source

1. Edit under `packs/<name>/`.
2. Bump `packs/<name>/pack.yaml` (and `cli_compat` if needed).
3. Update [`catalog.yaml`](catalog.yaml).
4. Package: `./scripts/package-pack.sh core`
5. Publish via [docs/release-workflow.md](docs/release-workflow.md).

Do **not** commit `dist/` unless your process requires it.

## Packs

| Pack | Path | Contents |
|------|------|----------|
| `core` | `packs/core` | Harness commands/rules/skills, templates, blueprint profiles |
| `prompts` | `packs/prompts` | Prompt library |
| `memories` | `packs/memories` | Root memory skeletons |
| `examples` | `packs/examples` | Consumer examples |

## Docs

| Document | Contents |
|---|---|
| [docs/README.md](docs/README.md) | Documentation index |
| [docs/skills.md](docs/skills.md) | Skill inventory (SoT) |
| [docs/profiles.md](docs/profiles.md) | Profile inventory (SoT) |
| [docs/standards/skill-naming.md](docs/standards/skill-naming.md) | Skill naming (SoT) |
| [docs/release-workflow.md](docs/release-workflow.md) | Assets release runbook |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
