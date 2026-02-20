#!/bin/bash

cd "$(dirname "$0")"
chmod +x ./*.desktop ./*.sh 2>/dev/null
TARGET_DIR="$HOME/.local/share/applications"
mkdir -p "$TARGET_DIR"
echo "🚀 Syncing and overwriting .desktop files..."
cp -vf ./*.desktop "$TARGET_DIR/"
update-desktop-database "$TARGET_DIR" 2>/dev/null
echo "✨ Done! Semua shortcut udah executable dan standby di sistem."
