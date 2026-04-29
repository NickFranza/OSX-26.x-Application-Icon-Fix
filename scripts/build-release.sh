#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_NAME="IconFix"
BUILD_DIR="$ROOT_DIR/build"
RELEASE_DIR="$ROOT_DIR/releases"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR" "$RELEASE_DIR"

xcodebuild \
  -project "$ROOT_DIR/IconFix.xcodeproj" \
  -scheme "$APP_NAME" \
  -configuration Release \
  -derivedDataPath "$BUILD_DIR/DerivedData" \
  build

APP_PATH=$(find "$BUILD_DIR/DerivedData/Build/Products/Release" -maxdepth 1 -name "$APP_NAME.app" -type d | head -n 1)
if [[ -z "$APP_PATH" ]]; then
  echo "Could not find built app."
  exit 1
fi

rm -rf "$BUILD_DIR/$APP_NAME.app"
cp -R "$APP_PATH" "$BUILD_DIR/$APP_NAME.app"

cd "$BUILD_DIR"
zip -qry "$RELEASE_DIR/IconFix-v2.0.0-Native-macOS-App.zip" "$APP_NAME.app"

echo "Built release: $RELEASE_DIR/IconFix-v2.0.0-Native-macOS-App.zip"
