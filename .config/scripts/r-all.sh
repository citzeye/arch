#!/bin/bash

# --- 1. Manual Copy & Source ZSHRC ---
cp ~/loonix/.config/zshs/.zshrc ~/.zshrc
zsh -c "source ~/.zshrc"

# --- 2. Reload config Waypaper ---
waypaper --restore 

# --- 3. Reload config Bar & Notif ---
pkill waybar; waybar &
pkill dunst; dunst &

# --- 4. Reload config Hyprland ---
hyprctl reload

# --- 5. Reload config Kitty ---
pkill -USR1 kitty

notify-send "Nuclear Refresh Done!"
