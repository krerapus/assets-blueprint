#!/usr/bin/env bash
# Usage: check-catalog-version.sh <pack> <expected-version>
set -euo pipefail
PACK="${1:?pack}"
WANT="${2:?version}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
GOT="$(PACK="$PACK" python3 - <<'PY'
import os, re, sys
pack = os.environ["PACK"]
text = open("catalog.yaml").read()
for block in re.split(r"(?m)^  - name:\s*", text):
    if not block.strip():
        continue
    name = block.splitlines()[0].strip().strip("\"'")
    if name != pack:
        continue
    m = re.search(r"(?m)^    version:\s*[\"']?([^\"'\s#]+)", block)
    if m:
        print(m.group(1))
        sys.exit(0)
sys.exit(1)
PY
)"
if [[ "$GOT" != "$WANT" ]]; then
  echo "error: catalog.yaml ${PACK}.version ($GOT) != expected ($WANT)" >&2
  exit 1
fi
echo "catalog OK: ${PACK}=${GOT}"
