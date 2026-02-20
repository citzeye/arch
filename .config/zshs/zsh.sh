#!/bin/bash

# Define paths for this specific module
SOURCE_FILE="$(pwd)/.zshrc"
TARGET_FILE="$HOME/.zshrc"

if [ "$1" == "install" ]; then
    # --- INSTALL MODE (Copy files so they survive the cleanup) ---
    echo "📦 Copying files to system..."
    cp -f "$SOURCE_FILE" "$TARGET_FILE"
else
    # --- DEV MODE (Manual symlink for your local editing) ---
    echo "🔗 Creating symlink for development..."
    rm -f "$TARGET_FILE"
    ln -s "$SOURCE_FILE" "$TARGET_FILE"
fi
