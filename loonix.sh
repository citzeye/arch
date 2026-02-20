#!/bin/bash

# =========================================================
# LOONIX INSTALLER (ROOT VERSION)
# =========================================================

# --- Identifikasi ---
USER_NOW=$(whoami)
IS_DEV=false
[[ "$USER_NOW" == "citz" ]] && IS_DEV=true

echo "--- Starting Full Installation: Loonix Project ---"

# 1. Essential Folders
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/.config"

# 2. Permissions
chmod +x ./.config/scripts/*.sh

# 3. Priority Run (Apps & Drivers)
PRIORITY=("apps")
for p in "${PRIORITY[@]}"; do
    script_file="./.config/scripts/$p.sh"
    [ -f "$script_file" ] && bash "$script_file" install
done

# 4. CONFIG DEPLOYMENT (Symlink vs Copy)
echo "🔗 Deploying Configurations..."
DOTS_DIR="$(pwd)/.config"
TARGET_DIR="$HOME/.config"

for folder in "$DOTS_DIR"/*/; do
    folder_name=$(basename "$folder")
    
    # Filter folder internal
    [[ "$folder_name" == "apps" || "$folder_name" == "scripts" ]] && continue

    if [ "$IS_DEV" = true ]; then
        # Buat Lo: Symlink (Path Absolut)
        ln -sf "$(pwd)/.config/$folder_name" "$TARGET_DIR/"
        echo "   [DEV] Symlinked $folder_name"
    else
        # Buat User: Copy (Permanen)
        cp -r "$folder" "$TARGET_DIR/"
        echo "   [USER] Installed $folder_name"
    fi
done

# 5. Sisa Script
for script in ./.config/scripts/*.sh; do
    filename=$(basename "$script")
    [[ " ${PRIORITY[*]} " =~ " ${filename%.sh} " || "$filename" == "deploy.sh" || "$filename" == "r-all.sh" ]] && continue
    bash "$script" install
done

# 6. Refresh Zsh
zsh -c "source ~/.zshrc"

echo "--- 🎉 Loonix Installation Finished! ---"

# 7. Self-Destruct (Hanya untuk User/Cloner)
if [ "$IS_DEV" = false ]; then
    rm -- "$0"
fi