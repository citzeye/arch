#!/bin/bash

# --- GPU Detection & Recommendation ---
echo "--- Scanning Hardware for GPU Drivers ---"

# Detect VGA or 3D controllers
GPU_LIST=$(lspci | grep -E "VGA|3D")
echo "Detected Hardware:"
echo "$GPU_LIST"

RECOMMENDED_DRIVERS=()

# Logic for NVIDIA
if echo "$GPU_LIST" | grep -iq "NVIDIA"; then
    echo "-> [SUGGESTION] NVIDIA detected. You should add: nvidia-dkms nvidia-utils"
    # RECOMMENDED_DRIVERS+=("nvidia-dkms" "nvidia-utils") # Uncomment to auto-add
fi

# Logic for Intel
if echo "$GPU_LIST" | grep -iq "Intel"; then
    echo "-> [SUGGESTION] Intel detected. You should add: vulkan-intel intel-media-driver"
fi

# Logic for AMD
if echo "$GPU_LIST" | grep -iq "AMD|ATI"; then
    echo "-> [SUGGESTION] AMD detected. You should add: xf86-video-amdgpu vulkan-radeon"
fi

echo "------------------------------------------"
sleep 2 # Give user time to read the suggestion

echo "--- Installing Comprehensive App List ---"

# 1. Install Apps via Pacman
APPS=(
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm" "kitty" "wofi" "dunst" "libnotify"
    "micro" "thunar" "thunar-archive-plugin" "gvfs" "zoxide" "eza" "zsh" "btop" "fastfetch"
    "grim" "slurp" "cliphist" "wl-clipboard" "polkit-kde-agent" "network-manager-applet"
    "ttf-nerd-fonts-symbols" "fontconfig" "nwg-look" "hyprshot" "hyprpaper" "hypridle" "hyprlock"
    "qt5-wayland" "qt6-wayland" "qt5ct" "zsh-autosuggestions" "zsh-syntax-highlighting" "mesa" "ufw"
    "upower" "adwaita-icon-theme" "libpulse" "rsync" "playerctl" "mpris" "gtk3" "gtk4"
)

sudo pacman -S --needed "${APPS[@]}" --noconfirm

# 4. Change Default Shell to Zsh
# Using 'sudo chsh' is more reliable for the current user
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s $(which zsh) $USER
fi

# --- Firewall Configuration (UFW) ---
echo "Configuring Firewall..."

# Enable and start UFW service
sudo systemctl enable --now ufw

# Set default policies: Deny all incoming, Allow all outgoing
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow common essential ports (optional, e.g., SSH if you need it)
# sudo ufw allow ssh

# Activate the firewall
sudo ufw --force enable

echo "Firewall is now ACTIVE and will start on boot."

echo "--- Apps Installer Done! ---"
