# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Pack versions are tracked per pack in `catalog.yaml` / `packs/*/pack.yaml`. This file records notable pack and catalog changes across releases.

## [Unreleased]

### Added

- `scripts/render-release-notes.sh` — compact GitHub Release notes from CHANGELOG `### Highlights` (wired into Assets Release / Pre-release)

## [1.5.2] - 2026-09-29

### Highlights

- Skills inventory clarified (🟦 = Blueprint-original)
- Pack version SoT is `pack.yaml` (synced with `catalog.yaml`)
- Human-triggered pack pre-release → production flow

### Added

- Root `CHANGELOG.md` (Keep a Changelog) for pack/catalog release notes
- Assets pre-release workflow and release-workflow docs for human-triggered pack publishes
- Catalog version check helper for release packaging
- Skills inventory as Skill / Intent / Notes tables; 🟦 marks Blueprint-original skills

### Changed

- Assets release pipeline aligned with CLI two-step pre-release → production flow
- Docs architecture cleanup: slim README (link CLI architecture-split), PROPOSAL marked Accepted (Wave 1)
- Drop redundant `packs/core/VERSION`; pack semver SoT is `pack.yaml` (keep `catalog.yaml` in sync for publish)
- Clearer Assets Pre-release/Release confirm errors when CLI vs pack version is confused

[Unreleased]: https://github.com/krerapus/assets-blueprint/compare/core-v1.5.2...HEAD
[1.5.2]: https://github.com/krerapus/assets-blueprint/releases/tag/core-v1.5.2
