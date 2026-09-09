# assets-blueprint

Independently versioned static resources for the [Blueprint CLI](https://github.com/krerapus/agent-harness-blueprint).

## Packs

| Pack | Path | Contents |
|------|------|----------|
| `core` | `packs/core` | Harness commands/rules/skills, templates, blueprint profiles |
| `prompts` | `packs/prompts` | Prompt library |
| `memories` | `packs/memories` | Root memory skeletons |
| `examples` | `packs/examples` | Consumer examples |

Each pack has its own `pack.yaml` (`version`, `cli_compat`) and is released as a separate GitHub Release asset (`<pack>-v<semver>.tar.gz`).

## Catalog

[`catalog.yaml`](catalog.yaml) lists the latest pack versions and release asset names. The CLI caches this under `~/.cache/blueprint/catalog/`.

## Local development

```bash
# From a sibling checkout of agent-harness-blueprint:
export BLUEPRINT_ASSETS_ROOT="$(pwd)"
# or rely on auto-detect of ../assets-blueprint
```

## Release

```bash
./scripts/package-pack.sh core
# Creates dist/core-v1.4.0.tar.gz + .sha256
```

Tag and publish: `core-v1.4.0` (see `.github/workflows/assets-release.yml`).

## Layout

```text
assets-blueprint/
├── catalog.yaml
├── packs/
│   ├── core/
│   ├── prompts/
│   ├── memories/
│   └── examples/
└── scripts/
```
