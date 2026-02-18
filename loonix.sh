#!/bin/bash

# =========================================================
# LOONIX INSTALLER (FINAL VERSION)
# =========================================================

echo "--- Starting Full Installation ---"

# 1. Ensure essential local bin directory exists
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Pictures/Screenshots"

# 2. Set execute permission for all scripts inside .config
find ./.config -type f -name "*.sh" -exec chmod +x {} +

# Priority scripts to run first
PRIORITY=("apps" "yays")

# 3. Run Priority Scripts
for folder in "${PRIORITY[@]}"; do
    script_file=$(find "./.config/.$folder" -name "*.sh" 2>/dev/null)
    if [ -f "$script_file" ]; then
        echo "🚀 Priority Run: $script_file"
        pushd "$(dirname "$script_file")" > /dev/null
        ./$(basename "$script_file") install
        popd > /dev/null
    fi
done

# 4. Run Remaining Scripts in .config subfolders
find ./.config -mindepth 2 -name "*.sh" | while read -r script; do
    is_priority=false
    for p in "${PRIORITY[@]}"; do
        if [[ "$script" == *"/.${p}/"* ]]; then
            is_priority=true
            break
        fi
    done

    if [ "$is_priority" = false ]; then
        echo "🚀 Running: $script"
        pushd "$(dirname "$script")" > /dev/null
        ./$(basename "$script") install
        popd > /dev/null
    fi
done

# 5. Refresh shell configuration
source ~/.zshrc

echo "--- 🧹 Final Cleanup ---"

# Delete all .sh files inside hidden folders in .config
# EXCEPT for deploy.sh and r-all.sh (Safety Filter)
find ./.config -maxdepth 3 -type f -name "*.sh" ! -name "deploy.sh" ! -name "r-all.sh" -delete

echo "--- 🎉 Done ---"

# 6. Self-destruct this installer
rm -- "$0"
