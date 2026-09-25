# Pack release workflow (human-triggered)

Two manual Actions — **do not** release by pushing a tag alone.

1. **Assets Pre-release** — non-production (`core-v1.5.2-rc.1`, GitHub Pre-release)
2. **Assets Release** — production (`core-v1.5.2`)

Neither updates the Homebrew Formula. Formula updates come from **CLI Release** only.

## Pre-release (test)

[Actions → Assets Pre-release](https://github.com/krerapus/assets-blueprint/actions/workflows/assets-prerelease.yml)

```bash
gh workflow run "Assets Pre-release" --repo krerapus/assets-blueprint \
  -f pack=core -f confirm_version=1.5.2 -f pre_label=rc.1 -f dry_run=false
```

## Production

[Actions → Assets Release](https://github.com/krerapus/assets-blueprint/actions/workflows/assets-release.yml)

```bash
gh workflow run "Assets Release" --repo krerapus/assets-blueprint \
  -f pack=core -f confirm_version=1.5.2 -f tested_pre_label=rc.1 -f dry_run=false
```

## Cross-repo order

1. Assets Pre-release → test  
2. Assets Release  
3. CLI Pre-release → test  
4. CLI Release (latest + Formula)

Full matrix: [CLI release-workflow.md](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/release-workflow.md).
