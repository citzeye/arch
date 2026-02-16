#!/bin/bash

echo "--- Starting Full Installation ---"

find . -type f -name "*.sh" -exec chmod +x {} +

PRIORITY=("apps" "yays")

for folder in "${PRIORITY[@]}"; do
    script_file=$(find "./.$folder" -name "*.sh" 2>/dev/null)
    if [ -f "$script_file" ]; then
        echo "🚀 Priority Run: $script_file"
        pushd "$(dirname "$script_file")" > /dev/null
        ./$(basename "$script_file") install
        popd > /dev/null
    fi
done

find . -mindepth 2 -name "*.sh" | while read -r script; do
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

mkdir -p $HOME/Pictures/Screenshots

echo "--- 🧹 Final Cleanup ---"
find . -maxdepth 1 -type d -name ".*" ! -name "." ! -name ".git" -exec rm -rf {} +

echo "--- 🎉 Done ---"
