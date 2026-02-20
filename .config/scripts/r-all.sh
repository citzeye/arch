#!/bin/bash

# 1. Reload config Waypaper
waypaper --restore 

# 2. Reload config Bar & Notif
pkill waybar; waybar &
pkill dunst; dunst &

# 3. Reload config Hyprland
hyprctl reload

# 4. Reload config Kitty
pkill -USR1 kitty

notify-send "Nuclear Refresh Done!"
