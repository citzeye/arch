#!/bin/bash

# --- 🔠 Loonix Font System Installation ---

# Ambil path root repo secara dinamis
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_FONTS_DIR="$REPO_ROOT/.config/fonts"
LOCAL_FONTS_DIR="$HOME/.local/share/fonts"

# Cek apakah dipanggil dengan argumen 'install' (biar sinkron sama loonix.sh)
if [[ "$1" == "install" ]]; then
    echo "🚀 Installing all fonts from Loonix config..."

    if [ -d "$REPO_FONTS_DIR" ]; then
        echo "🔗 Source: $REPO_FONTS_DIR"
        mkdir -p "$LOCAL_FONTS_DIR"
        
        # Copy file font
        cp -uv "$REPO_FONTS_DIR"/* "$LOCAL_FONTS_DIR/" 2>/dev/null
        
        # Set permission file biar kebaca system
        find "$LOCAL_FONTS_DIR" -type f -exec chmod 644 {} +
        
        # Refresh Cache
        echo "🔄 Refreshing system font cache..."
        fc-cache -f
        echo "✅ Success! All fonts are now installed."
    else
        echo "❌ Error: Folder '$REPO_FONTS_DIR' not found!"
        exit 1
    fi
fi