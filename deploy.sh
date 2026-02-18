#!/bin/bash

# Ensure rsync is installed
if ! command -v rsync &> /dev/null; then
    echo "❌ Error: rsync is not installed. Install it with: sudo pacman -S rsync"
    exit 1
fi

echo "🚀 Deploying configs from loonix to system..."

# 1. Sync folder .config standar (Hypr, Kitty, Waybar, dll)
rsync -av --exclude '.git/' ~/loonix/.config/ ~/.config/

# 2. FIX UNTUK THUNAR (Deploy .desktop files)
# File dari ~/loonix/.config/.desktops/ harus ke ~/.local/share/applications/
mkdir -p ~/.local/share/applications
cp ~/loonix/.config/.desktops/*.desktop ~/.local/share/applications/ 2>/dev/null

# 3. DEPLOY BINARIES
# File dari ~/loonix/.config/.locals/bin/ harus ke ~/.local/bin/
mkdir -p ~/.local/bin
cp -r ~/loonix/.config/.locals/bin/* ~/.local/bin/ 2>/dev/null

# 4. DEPLOY ZSHRC
cp ~/loonix/.config/.zsh/.zshrc ~/.zshrc

echo "✅ Success! Semua config, file desktop, dan binary telah dideploy."
