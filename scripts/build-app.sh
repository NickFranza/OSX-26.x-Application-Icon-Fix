#!/bin/bash

# Build IconFix.app from the AppleScript source.
# Requires macOS with osacompile available.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_PATH="$ROOT_DIR/IconFix.app"
SRC_PATH="$ROOT_DIR/src/IconFix.applescript"

if [[ ! -f "$SRC_PATH" ]]; then
  echo "Missing source file: $SRC_PATH"
  exit 1
fi

rm -rf "$APP_PATH"
osacompile -o "$APP_PATH" "$SRC_PATH"

echo "Built: $APP_PATH"
