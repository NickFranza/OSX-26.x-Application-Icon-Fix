#!/bin/bash

# Build IconFix.app from AppleScript source and apply custom app icon.
# Requires macOS with osacompile available.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_PATH="$ROOT_DIR/IconFix.app"
SRC_PATH="$ROOT_DIR/src/IconFix.applescript"
ICON_PATH="$ROOT_DIR/assets/IconFix.icns"
PLIST_PATH="$APP_PATH/Contents/Info.plist"
RESOURCES_PATH="$APP_PATH/Contents/Resources"

if [[ ! -f "$SRC_PATH" ]]; then
  echo "Missing source file: $SRC_PATH"
  exit 1
fi

if [[ ! -f "$ICON_PATH" ]]; then
  echo "Missing icon file: $ICON_PATH"
  exit 1
fi

rm -rf "$APP_PATH"
osacompile -o "$APP_PATH" "$SRC_PATH"

mkdir -p "$RESOURCES_PATH"
cp "$ICON_PATH" "$RESOURCES_PATH/IconFix.icns"

/usr/libexec/PlistBuddy -c "Set :CFBundleName IconFix" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleName string IconFix" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName IconFix" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string IconFix" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.nixintech.iconfix" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string com.nixintech.iconfix" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile IconFix" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleIconFile string IconFix" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString 1.0.0" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleShortVersionString string 1.0.0" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion 1.0.0" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 1.0.0" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :LSMinimumSystemVersion 10.13" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :LSMinimumSystemVersion string 10.13" "$PLIST_PATH"
/usr/libexec/PlistBuddy -c "Set :NSHighResolutionCapable true" "$PLIST_PATH" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :NSHighResolutionCapable bool true" "$PLIST_PATH"

touch "$APP_PATH"
echo "Built: $APP_PATH"
echo "Icon applied: $RESOURCES_PATH/IconFix.icns"
