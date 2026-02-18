#!/bin/bash

# Ensure rsync is installed
if ! command -v rsync &> /dev/null; then
    echo "❌ Error: rsync is not installed. Install it with: sudo pacman -S rsync"
    exit 1
fi

echo "🚀 Deploying configs from loonix to system..."

# Sync .config folder from repo to ~/.config
# --exclude '.git' to avoid copying git metadata
rsync -av --exclude '.git/' ~/loonix/.config/ ~/.config/

# Ensure .zshrc in home is a physical file (not a broken symlink)
cp ~/loonix/.config/.zsh/.zshrc ~/.zshrc

echo "✅ Success! Files from loonix have been deployed to the system."
