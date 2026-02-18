#!/bin/bash

# --- 1. Bootstrapping Yay (Already solid) ---
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git
    pushd yay > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf yay
fi

# --- 2. Defining AUR Packages ---
AUR_APPS=(
    "bibata-cursor-theme-bin"
    "udevil-git"
    "brave-browser-bin"
    "aylurs-gtk-shell"      # The main AGS shell
    "gtk-layer-shell"       # Required for bar positioning in Wayland
    "brightnessctl"         # For screen brightness control widgets
)

# --- 3. Execution ---
if [ "$1" == "install" ]; then
    echo "--- Installing AUR Packages ---"
    # Added gjs & upower via pacman first since they are in official repos
    # This speeds up the process before compiling AGS
    sudo pacman -S --needed gjs upower adwaita-icon-theme --noconfirm
    
    yay -S --needed "${AUR_APPS[@]}" --noconfirm
fi
