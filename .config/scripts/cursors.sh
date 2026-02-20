#!/bin/bash

# =========================================================
#  LOONIX - CURSOR INSTALLER (cursors.sh)
#  Target: Volantes Light Cursors (Full Installation)
# =========================================================

# --- 1. Setup Path Dinamis ---
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_CURSOR_DIR="$REPO_ROOT/.config/cursors"
LOCAL_ICONS_DIR="$HOME/.icons"
THEME_NAME="volantes_light_cursors"

# --- 2. Proses Instalasi ---
if [[ "$1" == "install" ]]; then
    echo "🚀 Installing Volantes Cursors..."

    if [ -d "$REPO_CURSOR_DIR/$THEME_NAME" ]; then
        # Pastikan folder icons ada di home
        mkdir -p "$LOCAL_ICONS_DIR"

        # --- Logic Dual Perspektif: Bre (Dev) vs User (Cloner) ---
        if [[ "$(whoami)" == "citz" ]]; then
            # Buat lo (Dev): Pake Symlink biar sinkron sama repo github.com/citzeye/loonix
            ln -sfn "$REPO_CURSOR_DIR/$THEME_NAME" "$LOCAL_ICONS_DIR/"
            echo "   -> [DEV] Symlinked: $THEME_NAME"
        else
            # Buat Cloner: Copy fisik biar kursor nggak ilang pas repo dihapus
            cp -rf "$REPO_CURSOR_DIR/$THEME_NAME" "$LOCAL_ICONS_DIR/"
            echo "   -> [USER] Copied: $THEME_NAME"
        fi

        # --- 3. XDG Standard (Biar Full sampe aplikasi Legacy/X11) ---
        # Ini biar kursor nggak balik jadi default Arch di dalem aplikasi tertentu
        mkdir -p "$LOCAL_ICONS_DIR/default"
        echo -e "[Icon Theme]\nInherits=$THEME_NAME" > "$LOCAL_ICONS_DIR/default/index.theme"

        # --- 4. Apply Instantly (Real-time Activation) ---
        # Langsung tembak ke Hyprland yang lagi jalan
        if command -v hyprctl &> /dev/null; then
            hyprctl setcursor "$THEME_NAME" 24 2>/dev/null
        fi

        # Langsung tembak ke GTK (Thunar, Brave, dll)
        if command -v gsettings &> /dev/null; then
            gsettings set org.gnome.desktop.interface cursor-theme "$THEME_NAME" 2>/dev/null
        fi

        echo "✅ Full Cursor Setup Done! Kursor $THEME_NAME sekarang aktif."
    else
        echo "❌ Error: Folder $THEME_NAME tidak ditemukan di $REPO_CURSOR_DIR"
        exit 1
    fi
fi