# Pack release workflow (human-triggered)

Pack releases are **manual**: GitHub Actions → **Assets Release** → Run workflow.

Pushing a git tag does **not** start a release. The workflow creates `<pack>-v<version>` if needed and publishes the pack tarball.

This does **not** update the Homebrew Formula. Formula updates come from the CLI **CLI Release** workflow only.

## Steps

1. Merge version bumps to `master` (`packs/<pack>/pack.yaml`, `packs/<pack>/VERSION` if present, `catalog.yaml`).
2. Open [Actions → Assets Release](https://github.com/krerapus/assets-blueprint/actions/workflows/assets-release.yml).
3. Run on `master` with:
   - **pack** — which pack to publish
   - **confirm_version** — must match `pack.yaml` / `catalog.yaml`
   - **dry_run** — optional package-only check
4. Verify the GitHub Release asset `\<pack\>-v\<ver\>.tar.gz`.

```bash
gh workflow run "Assets Release" --repo krerapus/assets-blueprint \
  -f pack=core -f confirm_version=1.5.2 -f dry_run=false
```

## Cross-repo order

1. Publish packs here (at least `core` when harness content changed).
2. Run **CLI Release** on [agent-harness-blueprint](https://github.com/krerapus/agent-harness-blueprint/actions/workflows/cli-release.yml) so the Formula tracks the new CLI (if any).

Full matrix and Formula details: [CLI release-workflow.md](https://github.com/krerapus/agent-harness-blueprint/blob/master/docs/release-workflow.md).
