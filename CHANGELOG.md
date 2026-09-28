# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Pack versions are tracked per pack in `catalog.yaml` / `packs/*/pack.yaml`. This file records notable pack and catalog changes across releases.

## [Unreleased]

### Added

- Root `CHANGELOG.md` (Keep a Changelog) for pack/catalog release notes

### Changed

- Docs architecture cleanup: slim README (link CLI architecture-split), PROPOSAL marked Accepted (Wave 1), remove obsolete CLI skills-mirror wording

## [1.5.2] - 2026-09-26

### Added

- Assets pre-release workflow and release-workflow docs for human-triggered pack publishes
- Catalog version check helper for release packaging

### Changed

- Assets release pipeline aligned with CLI two-step pre-release → production flow

[Unreleased]: https://github.com/krerapus/assets-blueprint/compare/core-v1.5.2...HEAD
[1.5.2]: https://github.com/krerapus/assets-blueprint/releases/tag/core-v1.5.2
