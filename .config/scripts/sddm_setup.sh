#!/bin/bash

# =========================================================
#  LOONIX - SDDM THEME INSTALLER (sddm_setup.sh)
#  Target: Chili Theme + Carbon Background
# =========================================================

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
THEME_SRC="$REPO_ROOT/extra/sddm-theme/chili"
THEME_DEST="/usr/share/sddm/themes/chili"
WALLPAPER_SRC="$REPO_ROOT/.config/wallpapers/carbon.jpg"

if [[ "$1" == "install" ]]; then
    echo "🎨 Setting up SDDM Theme (Chili - Carbon Edition)..."

    # 1. Pastikan folder tema ada di repo
    if [ ! -d "$THEME_SRC" ]; then
        echo "❌ Error: Folder tema di $THEME_SRC gak ada!"
        exit 1
    fi

    # 2. Copy Tema ke Folder System
    echo "   -> Copying theme to system..."
    sudo mkdir -p /usr/share/sddm/themes/
    sudo cp -r "$THEME_SRC" /usr/share/sddm/themes/

    # 3. Inject Carbon Wallpaper ke Tema
    if [ -f "$WALLPAPER_SRC" ]; then
        echo "   -> Applying Carbon Wallpaper to SDDM..."
        sudo cp "$WALLPAPER_SRC" "$THEME_DEST/assets/background.jpg"
    fi

    # 4. Aktifkan Tema & Kursor di Config SDDM
    echo "   -> Configuring /etc/sddm.conf.d/..."
    sudo mkdir -p /etc/sddm.conf.d

    # Set Theme
    echo -e "[Theme]\nCurrent=chili" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null

    # Set Cursor (Samain sama Volantes lo)
    echo -e "[Theme]\nCursorTheme=volantes_light_cursors" | sudo tee /etc/sddm.conf.d/general.conf > /dev/null

    # 5. Enable Service
    sudo systemctl enable sddm

    echo "✅ SDDM is now Carbonized & Ready!"
fi