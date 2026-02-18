#!/bin/bash

echo "--- Installing Comprehensive App List ---"

# 1. Install Apps via Pacman
APPS=(
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm"
    "kitty" "wofi" "waybar" "dunst" "libnotify"
    "micro" "thunar" "thunar-archive-plugin" "gvfs"
    "zoxide" "eza" "zsh" "htop" "fastfetch"
    "grim" "slurp" "cliphist" "wl-clipboard"
    "polkit-kde-agent" "network-manager-applet"
    "ttf-nerd-fonts-symbols" "fontconfig"
    "nwg-look" "hyprshot" "hyprpaper" "hypridle" "hyprlock"
    "qt5-wayland" "qt6-wayland" "qt5ct"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

sudo pacman -S --needed "${APPS[@]}" --noconfirm

# 4. Ganti Default Shell ke Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

echo "--- Apps Installer Done! ---"
