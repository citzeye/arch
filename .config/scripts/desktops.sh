#!/bin/bash

# --- 🖥️ Loonix Desktop Shortcut Sync (dsync) ---

# 1. Setup Path Dinamis
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SOURCE_DIR="$REPO_ROOT/.config/desktops"
TARGET_DIR="$HOME/.local/share/applications"

# 2. Cek Folder Source
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Folder shortcut di $SOURCE_DIR gak ketemu!"
    exit 1
fi

mkdir -p "$TARGET_DIR"

echo "🚀 Syncing .desktop files from $SOURCE_DIR..."

# 3. Copy & Overwrite
# Pake -u (update) biar cuma copy kalau ada perubahan, atau -f buat paksa.
cp -vf "$SOURCE_DIR"/*.desktop "$TARGET_DIR/"

# 4. Set Permission & Refresh Database
# Permission 644 (rw-r--r--) udah standar paling aman buat .desktop
chmod 644 "$TARGET_DIR"/*.desktop
update-desktop-database "$TARGET_DIR" 2>/dev/null

echo "✨ Done! Semua shortcut (Micro, Code, Thunar) udah standby di launcher."