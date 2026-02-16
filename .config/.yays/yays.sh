#!/bin/bash

if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git
    pushd yay > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf yay
fi

AUR_APPS=(
    "bibata-cursor-theme-bin"
    "udevil-git"
    "waypaper"
    "wlogout"
    "zen-browser-bin"
)

if [ "$1" == "install" ]; then
    yay -S --needed "${AUR_APPS[@]}" --noconfirm
fi
