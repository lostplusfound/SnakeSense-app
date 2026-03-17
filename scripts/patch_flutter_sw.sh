#!/usr/bin/env bash
set -euo pipefail

SW_FILE="build/web/flutter_service_worker.js"

if [[ ! -f "$SW_FILE" ]]; then
  echo "Service worker not found at $SW_FILE; skipping patch."
  exit 0
fi

if grep -q "Bypass SW cache for model files" "$SW_FILE"; then
  echo "Service worker patch already applied."
  exit 0
fi

python3 - <<'PY'
from pathlib import Path

sw_path = Path("build/web/flutter_service_worker.js")
text = sw_path.read_text(encoding="utf-8")
needle = "  // If the URL is not the RESOURCE list then return to signal that the\n  // browser should take over.\n"
injection = (
    "  // Bypass SW cache for model files so the browser fetches them directly.\n"
    "  if (key.endsWith('.onnx') || key.includes('/models/')) {\n"
    "    return;\n"
    "  }\n"
)

if needle not in text:
    raise SystemExit("Expected fetch-handler marker not found; patch not applied.")

text = text.replace(needle, injection + needle, 1)
sw_path.write_text(text, encoding="utf-8")
print("Applied ONNX bypass patch to flutter_service_worker.js")
PY
