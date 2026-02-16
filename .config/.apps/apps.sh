#!/bin/bash

echo "--- Installing Comprehensive App List ---"

APPS=(
    "hyprland" "xdg-desktop-portal-hyprland" "uwsm"
    "kitty" "wofi" "waybar" "dunst" "libnotify"
    "micro" "thunar" "thunar-archive-plugin" "gvfs"
    "swww"
    "zoxide" "eza" "zsh" "htop" "fastfetch"
    "grim" "slurp" "cliphist" "wl-clipboard"
    "polkit-kde-agent" "network-manager-applet"
    "ttf-nerd-fonts-symbols" "fontconfig"
    "nwg-look" "hyprshot"
    "qt5-wayland" "qt6-wayland" "qt5ct"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

sudo pacman -S --needed "${APPS[@]}" --noconfirm
