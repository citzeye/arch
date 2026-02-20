#!/bin/bash

# --- 🖼️ Wallpaper Setup ---

echo "--- Setting up wallpapers ---"

# 1. Define paths 
# Pake $HOME biar aman di dalam variabel
REPO_WALLPAPER_DIR="$HOME/loonix/.config/.wallpapers" 
TARGET_DIR="$HOME/Pictures/Wallpapers"

# 2. Create target directory
mkdir -p "$TARGET_DIR"

# 3. Sync wallpapers from repo
# Gunakan eval atau pastikan path benar-benar terurai
if [ -d "$REPO_WALLPAPER_DIR" ]; then
    echo "--- Copying wallpapers to $TARGET_DIR ---"
    # Tambahkan quote pada path untuk jaga-jaga ada spasi
    cp -rv "$REPO_WALLPAPER_DIR"/* "$TARGET_DIR/"
else
    echo "⚠️  No wallpapers folder found at $REPO_WALLPAPER_DIR. Skipping."
fi

# 4. Initialize swww (if running)
if pgrep -x "swww-daemon" > /dev/null; then
    echo "--- swww-daemon is already running ---"
else
    echo "--- Starting swww-daemon ---"
    swww-daemon &
    # Kasih jeda dikit biar daemon bener-bener siap
    sleep 1 
fi

echo "--- ✅ Wallpaper sync complete! ---"
