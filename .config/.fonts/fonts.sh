#!/bin/bash

# --- 🔠 Font Installation & Sync Script ---

# 1. Install official fonts via pacman
echo "--- Installing base fonts from official repositories ---"
# Using --needed so it doesn't reinstall what's already there
sudo pacman -S --needed \
    ttf-jetbrains-mono-nerd \
    ttf-cascadia-code-nerd \
    noto-fonts-emoji \
    --noconfirm

# 2. Set Directory Paths
# Path to your repo's font folder
REPO_FONTS_DIR="./.fonts"
# Standard user font directory in Linux
LOCAL_FONTS_DIR="$HOME/.local/share/fonts"

# 3. Copy custom fonts from Repo to System
if [ -d "$REPO_FONTS_DIR" ]; then
    echo "--- Syncing custom fonts from repo to $LOCAL_FONTS_DIR ---"
    
    # Create the directory if it doesn't exist
    mkdir -p "$LOCAL_FONTS_DIR"
    
    # Find all .ttf and .otf files and copy them
    find "$REPO_FONTS_DIR" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp -v {} "$LOCAL_FONTS_DIR/" \;
    
    # Set correct permissions (Owner: Read/Write, Group/Others: Read)
    echo "--- Setting permissions for font files ---"
    chmod 644 "$LOCAL_FONTS_DIR"/*.ttf "$LOCAL_FONTS_DIR"/*.otf 2>/dev/null
else
    echo "⚠️  Repo font directory not found. Skipping custom font sync."
fi

# 4. Refresh System Font Cache
echo "--- Refreshing font cache. This might take a moment... ---"
fc-cache -fv

# 5. Optional: AUR Fonts via yay
if command -v yay &> /dev/null; then
    echo "--- Installing additional fonts from AUR ---"
    yay -S ttf-kode-mono --noconfirm
fi

echo "--- ✅ Font installation and sync complete! ---"
