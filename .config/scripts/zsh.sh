#!/bin/bash

# =========================================================
#  LOONIX - ZSH CONFIG INSTALLER (zsh.sh)
#  Target: Modular Zsh Setup (.config/zshs)
# =========================================================

# --- 1. Setup Path Dinamis ---
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_ZSH_DIR="$REPO_ROOT/.config/zshs"
TARGET_ZSHRC="$HOME/.zshrc"

# --- 2. Proses Instalasi ---
if [[ "$1" == "install" ]]; then
    echo "🚀 Configuring Loonix Zsh..."

    if [ -d "$REPO_ZSH_DIR" ]; then
        
        # --- Logic Dual Perspektif: Bre (Dev) vs User (Cloner) ---
        if [[ "$(whoami)" == "citz" ]]; then
            # Buat lo (Dev): Symlink .zshrc utama ke folder repo
            ln -sf "$REPO_ZSH_DIR/.zshrc" "$TARGET_ZSHRC"
            echo "   -> [DEV] Symlinked .zshrc to repo."
        else
            # Buat Cloner: Copy fisik filenya
            cp -f "$REPO_ZSH_DIR/.zshrc" "$TARGET_ZSHRC"
            echo "   -> [USER] Copied .zshrc to home."
        fi

        # --- 3. Pastikan Default Shell adalah Zsh ---
        # Kalau masih bash, kita arahin ke zsh
        if [[ "$SHELL" != *"zsh"* ]]; then
            echo "🔄 Changing default shell to Zsh..."
            chsh -s "$(which zsh)"
        fi

        echo "✅ Zsh Setup Done! Silakan buka tab baru di Kitty."
    else
        echo "❌ Error: Folder zshs gak ketemu di $REPO_ZSH_DIR"
        exit 1
    fi
fi