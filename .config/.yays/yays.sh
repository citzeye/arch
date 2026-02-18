#!/bin/bash

# --- 1. Bootstrapping Yay ---
if ! command -v yay &> /dev/null; then
    echo "Yay not found. Installing now..."
    sudo pacman -S --needed base-devel git --noconfirm
    # Using /tmp so it doesn't clutter your loonix folder
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf /tmp/yay
fi

# --- 2. Defining AUR Packages ---
AUR_APPS=(
    "bibata-cursor-theme-bin"
        "brave-browser-bin"
        "brightnessctl"
        # "gtk-layer-shell"  # Uncomment kalo pake waybar, comment kalo ga pake waybar 
)

# --- 3. Execution ---
if [ "$1" == "install" ]; then
    echo "--- Installing AUR Packages for Loonix ---"
    
    # We removed the sudo pacman -S part from here 
    # because it's already handled by your apps.sh
    
    yay -S --needed "${AUR_APPS[@]}" --noconfirm
fi
