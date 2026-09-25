#!/usr/bin/env bash
# Package a single assets pack into dist/<name>-v<ver>.tar.gz + sha256.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACK_NAME="${1:-}"
if [[ -z "$PACK_NAME" ]]; then
  echo "usage: $0 <pack-name>" >&2
  exit 2
fi

PACK_DIR="${ROOT}/packs/${PACK_NAME}"
if [[ ! -d "$PACK_DIR" ]]; then
  echo "error: pack not found: $PACK_DIR" >&2
  exit 1
fi
if [[ ! -f "${PACK_DIR}/pack.yaml" ]]; then
  echo "error: missing pack.yaml in $PACK_DIR" >&2
  exit 1
fi

# Optional second arg overrides version in the artifact name (for pre-releases).
# Usage: package-pack.sh <pack-name> [version-override]
VER_OVERRIDE="${2:-}"
VER="$(grep -E '^version:' "${PACK_DIR}/pack.yaml" | head -1 | awk '{print $2}' | tr -d '"')"
if [[ -n "$VER_OVERRIDE" ]]; then
  VER="$VER_OVERRIDE"
fi
if [[ -z "$VER" ]]; then
  echo "error: could not read version from pack.yaml" >&2
  exit 1
fi

OUT_DIR="${ROOT}/dist"
mkdir -p "$OUT_DIR"
ASSET="${PACK_NAME}-v${VER}.tar.gz"
OUT="${OUT_DIR}/${ASSET}"

rm -f "$OUT" "${OUT}.sha256"
tar -C "${ROOT}/packs" -czf "$OUT" "${PACK_NAME}"

if command -v shasum >/dev/null 2>&1; then
  (cd "$OUT_DIR" && shasum -a 256 "$ASSET" | awk '{print $1}') > "${OUT}.sha256"
elif command -v sha256sum >/dev/null 2>&1; then
  (cd "$OUT_DIR" && sha256sum "$ASSET" | awk '{print $1}') > "${OUT}.sha256"
else
  echo "warn: no sha256 tool; skipped checksum" >&2
fi

echo "wrote $OUT"
[[ -f "${OUT}.sha256" ]] && echo "sha256 $(cat "${OUT}.sha256")"
