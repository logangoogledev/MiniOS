#!/usr/bin/env bash
set -euo pipefail

# Download libv86 and wasm runtime into web/vendor/
# Usage: ./scripts/vendor_v86.sh

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
VENDOR_DIR="$ROOT_DIR/web/vendor"

mkdir -p "$VENDOR_DIR"

BASE_URLS=(
  "https://copy.sh/v86/build"
  "https://cdn.jsdelivr.net/gh/copy/v86@master/build"
)

FILES=("libv86.js" "v86.so")

echo "Vendorizing v86 runtime into $VENDOR_DIR"

for f in "${FILES[@]}"; do
  downloaded=false
  for base in "${BASE_URLS[@]}"; do
    url="$base/$f"
    echo "Trying $url"
    if curl -fsSL --retry 3 --retry-delay 2 -o "$VENDOR_DIR/$f" "$url"; then
      echo "Downloaded $f from $url"
      downloaded=true
      break
    else
      echo "Failed to download $url"
    fi
  done
  if [ "$downloaded" = false ]; then
    echo "ERROR: Could not download $f from any known host. Please check network or download manually into $VENDOR_DIR"
    exit 1
  fi
done

echo "Vendor files available at:"
ls -l "$VENDOR_DIR"

echo "Done."