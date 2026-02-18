#!/bin/bash

# --- Loonix Deployment Script: The "Don't Make Me Repeat Myself" Edition ---

# Master source from your playground
SOURCE="$HOME/loonix/.config"
TARGET="$HOME/.config"

echo "🚀 Deploying Loonix: Transforming your system into a hall of mirrors..."

# 1. THE MASS LINKING (The .config folders)
for item in "$SOURCE"/{.*,*}; do
    # Skip the annoying '.' and '..' directories
    [[ "$(basename "$item")" == "." || "$(basename "$item")" == ".." ]] && continue
    
    # Define the destination name
    dest_name=$(basename "$item")
    target_path="$TARGET/$dest_name"

    # Kill the existing folder/link before it starts nesting like a Russian doll
    rm -rf "$target_path"
    
    # Create the magic link
    ln -sfn "$item" "$target_path"
    echo "🔗 Linked: $dest_name -> Master Playground"
done


# THUNAR DESKTOP FIX (Because Thunar is picky)
mkdir -p ~/.local/share/applications
echo "📂 Linking desktop shortcuts... (So you don't have to use the terminal for EVERYTHING)"
for desktop_file in "$SOURCE"/.desktops/*.desktop; do
    [ -e "$desktop_file" ] || continue
    ln -sfn "$desktop_file" ~/.local/share/applications/"$(basename "$desktop_file")"
done

# BINARY DEPLOYMENT (The "I am Speed" section)
mkdir -p ~/.local/bin
echo "⚡ Linking custom binaries... (Your future self will thank you)"
for bin_file in "$SOURCE"/.locals/bin/*; do
    [ -e "$bin_file" ] || continue
    ln -sfn "$bin_file" ~/.local/bin/"$(basename "$bin_file")"
done

# ZSHRC (The Holy Grail)
echo "🐚 Linking .zshrc... (Making your terminal look like you're hacking NASA)"
ln -sfn "$SOURCE"/.zsh/.zshrc ~/.zshrc

# THE NUKE (Closing the quote and adding -i for alias support)
zsh -ci "nuke"

echo ""
echo "✅ Success! Your system is now officially a 'Loonix' puppet."
echo "💡 Pro tip: If you edit files in ~/loonix, the system updates INSTANTLY. No more copy-paste!"
