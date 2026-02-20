#!/bin/bash

# --- 🔠 Loonix Font System Installation ---

# 1. Set Directory Paths
REPO_FONTS_DIR="$HOME/loonix/.config/fonts"
LOCAL_FONTS_DIR="$HOME/.local/share/fonts"

echo "🚀 Installing all fonts from Loonix config to system..."

# 2. Sync fonts from Repo to System
if [ -d "$REPO_FONTS_DIR" ]; then
    echo "🔗 Source: $REPO_FONTS_DIR"
    
    mkdir -p "$LOCAL_FONTS_DIR"
    
    # Copy only files to prevent accidental folder permission changes
    cp -uv "$REPO_FONTS_DIR"/* "$LOCAL_FONTS_DIR/" 2>/dev/null
    
    # Only apply 644 to FILES in the local font directory
    # This prevents locking out folders
    find "$LOCAL_FONTS_DIR" -type f -exec chmod 644 {} +
else
    echo "❌ Error: Folder '$REPO_FONTS_DIR' not found!"
    exit 1
fi

# 3. Refresh Font Cache
echo "🔄 Refreshing system font cache..."
fc-cache -f

echo "✅ Success! All font are now installed."
