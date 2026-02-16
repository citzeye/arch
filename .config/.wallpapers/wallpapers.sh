#!/bin/bash

# --- 🖼️ Wallpaper Setup ---

echo "--- Setting up wallpapers ---"

# 1. Define paths
REPO_WALLPAPER_DIR="./.wallpapers"
TARGET_DIR="$HOME/Pictures/Wallpapers"

# 2. Create target directory
mkdir -p "$TARGET_DIR"

# 3. Sync wallpapers from repo
if [ -d "$REPO_WALLPAPER_DIR" ]; then
    echo "--- Copying wallpapers to $TARGET_DIR ---"
    cp -rv "$REPO_WALLPAPER_DIR"/* "$TARGET_DIR/"
else
    echo "⚠️  No .wallpapers folder found in repo. Skipping."
fi

# 4. Initialize swww (if running) to prevent waypaper errors
if pgrep -x "swww-daemon" > /dev/null; then
    echo "--- swww-daemon is already running ---"
else
    echo "--- Starting swww-daemon ---"
    swww-daemon &
fi

echo "--- ✅ Wallpaper sync complete! ---"
