#!/bin/bash

# IconFix - macOS icon cache reset utility
# Clears the Apple icon services cache and restarts Dock/Finder.

set -euo pipefail

APP_NAME="IconFix"
ICON_CACHE_PATH="/Library/Caches/com.apple.iconservices.store"

echo "[$APP_NAME] Clearing macOS icon services cache..."
sudo rm -rfv "$ICON_CACHE_PATH"

echo "[$APP_NAME] Restarting Dock..."
killall Dock || true

echo "[$APP_NAME] Restarting Finder..."
killall Finder || true

echo "[$APP_NAME] Complete. Icon cache has been reset."
