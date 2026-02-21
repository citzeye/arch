#!/bin/bash

# =========================================================
#  LOONIX - CURSOR INSTALLER (cursors.sh)
#  Target: Volantes Light (Home & System Level)
# =========================================================

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARBALL="$REPO_ROOT/.config/cursors/volantes-light-cursors.tar.gz"
LOCAL_ICONS_DIR="$HOME/.icons"
SYSTEM_ICONS_DIR="/usr/share/icons"
THEME_NAME="volantes_light_cursors"

if [[ "$1" == "install" ]]; then
    echo "📦 Extracting & Installing Cursors (Home & System)..."

    if [ -f "$TARBALL" ]; then
        # --- 1. SETUP UNTUK USER (HOME) ---
        mkdir -p "$LOCAL_ICONS_DIR"
        # Hapus dulu kalau ada symlink/folder lama biar gak bentrok
        rm -rf "$LOCAL_ICONS_DIR/$THEME_NAME"
        
        tar -xzf "$TARBALL" -C "$LOCAL_ICONS_DIR"
        echo "   -> Installed to $LOCAL_ICONS_DIR (User Level)"

        # XDG Standard for User
        mkdir -p "$LOCAL_ICONS_DIR/default"
        echo -e "[Icon Theme]\nInherits=$THEME_NAME" > "$LOCAL_ICONS_DIR/default/index.theme"

        # --- 2. SETUP UNTUK SYSTEM (ROOT/SDDM) ---
        echo "   -> Copying to $SYSTEM_ICONS_DIR (System Level)..."
        # Kita pake sudo karena /usr/share itu wilayah Root
        sudo rm -rf "$SYSTEM_ICONS_DIR/$THEME_NAME"
        sudo cp -r "$LOCAL_ICONS_DIR/$THEME_NAME" "$SYSTEM_ICONS_DIR/"
        
        # --- 3. APPLY CHANGES ---
        if command -v hyprctl &> /dev/null; then
            hyprctl setcursor "$THEME_NAME" 24 2>/dev/null
        fi
        
        if command -v gsettings &> /dev/null; then
            gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME" 2>/dev/null
        fi

        echo "✅ Cursor Volantes mendarat di Home & Root! SDDM pasti seneng."
    else
        echo "❌ Error: File $TARBALL gak ketemu!"
        exit 1
    fi
fi