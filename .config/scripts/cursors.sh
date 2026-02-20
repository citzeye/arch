#!/bin/bash

# =========================================================
#  LOONIX - CURSOR INSTALLER (cursors.sh)
#  Target: Volantes Light (From Tarball for Git Speed)
# =========================================================

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARBALL="$REPO_ROOT/.config/cursors/volantes-light-cursors.tar.gz"
LOCAL_ICONS_DIR="$HOME/.icons"
THEME_NAME="volantes_light_cursors"

if [[ "$1" == "install" ]]; then
    echo "📦 Extracting & Installing Cursors..."

    if [ -f "$TARBALL" ]; then
        mkdir -p "$LOCAL_ICONS_DIR"

        # 1. Ekstrak langsung ke folder icons
        # --strip-components=1 kalo di dalem tarball-nya ada folder lagi
        tar -xzf "$TARBALL" -C "$LOCAL_ICONS_DIR"
        
        echo "   -> Extracted to $LOCAL_ICONS_DIR"

        # 2. XDG Standard (Full Integration)
        mkdir -p "$LOCAL_ICONS_DIR/default"
        echo -e "[Icon Theme]\nInherits=$THEME_NAME" > "$LOCAL_ICONS_DIR/default/index.theme"

        # 3. Apply Instantly
        if command -v hyprctl &> /dev/null; then
            hyprctl setcursor "$THEME_NAME" 24 2>/dev/null
        fi
        
        if command -v gsettings &> /dev/null; then
            gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME" 2>/dev/null
        fi

        echo "✅ Full Cursor Setup Done! Git bakal enteng sekarang."
    else
        echo "❌ Error: File $TARBALL gak ketemu!"
        exit 1
    fi
fi