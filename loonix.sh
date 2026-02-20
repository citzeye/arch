#!/bin/bash

# =========================================================
# LOONIX INSTALLER (ROOT VERSION)
# =========================================================

echo "--- Starting Full Installation: Loonix Project ---"

# 1. Pastikan folder essential di Home sudah ada
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Pictures/Screenshots"

# 2. Kasih izin eksekusi ke semua script di folder scripts/
# Kita tembak relatif dari posisi loonix.sh berada
chmod +x ./.config/scripts/*.sh

# Priority list (Nama file tanpa .sh)
PRIORITY=("apps" "yays")

# 3. Jalankan Script Priority
for p in "${PRIORITY[@]}"; do
    script_file="./.config/scripts/$p.sh"
    if [ -f "$script_file" ]; then
        echo "🚀 Priority Run: $p.sh"
        bash "$script_file" install
    fi
done

# 4. Jalankan Sisa Script di folder scripts/
for script in ./.config/scripts/*.sh; do
    filename=$(basename "$script")
    
    # Jangan jalankan lagi yang sudah masuk Priority, 
    # dan jangan jalankan script utility seperti r-all atau deploy secara acak
    if [[ " ${PRIORITY[*]} " =~ " ${filename%.sh} " ]] || \
       [[ "$filename" == "deploy.sh" ]] || \
       [[ "$filename" == "r-all.sh" ]]; then
        continue
    fi

    echo "🚀 Running: $filename"
    bash "$script" install
done

# 5. Jalankan Deploy (Biar semua folder ter-link ke $HOME/.config)
if [ -f "./.config/scripts/deploy.sh" ]; then
    echo "🔗 Linking configurations..."
    bash "./.config/scripts/deploy.sh"
fi

# 6. Refresh Zsh
# Gunakan zsh -c karena source nggak bisa jalan langsung dari bash script
zsh -c "source ~/.zshrc"

echo "--- 🧹 Final Cleanup ---"
# Opsi hapus script (aktifkan jika untuk ISO sekali pakai)
# find ./.config/scripts/ -type f -name "*.sh" ! -name "deploy.sh" ! -name "r-all.sh" -delete

echo "--- 🎉 Loonix Installation Finished! ---"

# Self-destruct installer yang ada di root ini
rm -- "$0"
