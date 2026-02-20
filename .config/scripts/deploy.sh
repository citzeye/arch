#!/bin/bash

# --- Loonix Deployment Script: The "Don't Make Me Repeat Myself" Edition ---

# Master source from your playground
SOURCE="$HOME/loonix/.config"
TARGET="$HOME/.config"

echo "🚀 Deploying Loonix: Transforming your system into a hall of mirrors..."

# 1. THE MASS LINKING (The .config folders)
# Kita pakai * aja karena sekarang Bre udah nggak pakai titik untuk folder buatan sendiri
for item in "$SOURCE"/*; do
    # Define the destination name
    dest_name=$(basename "$item")
    target_path="$TARGET/$dest_name"

    # Kill the existing folder/link
    rm -rf "$target_path"
    
    # Create the magic link
    ln -sfn "$item" "$target_path"
    echo "🔗 Linked: $dest_name -> Master Playground"
done

# 2. DESKTOP FIX (Update path ke 'desktops' tanpa titik)
mkdir -p ~/.local/share/applications
echo "📂 Linking desktop shortcuts..."
for desktop_file in "$SOURCE"/desktops/*.desktop; do
    [ -e "$desktop_file" ] || continue
    ln -sfn "$desktop_file" ~/.local/share/applications/"$(basename "$desktop_file")"
done

# 3. BINARY DEPLOYMENT (Update path ke 'locals' tanpa titik)
mkdir -p ~/.local/bin
echo "⚡ Linking custom binaries..."
for bin_file in "$SOURCE"/locals/bin/*; do
    [ -e "$bin_file" ] || continue
    ln -sfn "$bin_file" ~/.local/bin/"$(basename "$bin_file")"
done

# 4. ZSHRC (Update path ke 'zshs' dan pastikan ~/.zshrc nembak ke sana)
echo "🐚 Linking .zshrc..."
ln -sfn "$SOURCE"/zshs/.zshrc ~/.zshrc

# THE NUKE (Reload all config)
zsh -ci "nuke"

echo ""
echo "✅ Success! Your system is now officially a 'Loonix' puppet."
