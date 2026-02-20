#!/bin/bash

# --- UI Enhancement ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}   LOONIX APPS - Master Installation      ${NC}"
echo -e "${BLUE}==========================================${NC}"

# --- 1. Path Setup ---
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OFFLINE_BIN_DIR="$REPO_ROOT/.config/apps"

# --- 2. Hardware Detection ---
GPU_LIST=$(lspci | grep -E "VGA|3D")
echo -e "${YELLOW}Hardware Detected:${NC}\n$GPU_LIST"

# --- 3. Offline Installation (Primary) ---
if [[ "$1" == "install" ]]; then
    echo -e "\n${GREEN}📦 Installing Offline Packages from .config/apps...${NC}"
    if [ -d "$OFFLINE_BIN_DIR" ] && ls "$OFFLINE_BIN_DIR"/*.pkg.tar.zst 1> /dev/null 2>&1; then
        sudo pacman -U --noconfirm "$OFFLINE_BIN_DIR"/*.pkg.tar.zst
    else
        echo -e "${RED}⚠️ No offline packages found. Skipping to online sync...${NC}"
    fi
fi

# --- 4. Online Sync (Cleanup/Missing Deps) ---
# Daftar aplikasi tetap lo jaga di sini sebagai backup
PACMAN_APPS=(
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm" 
    "kitty" "wofi" "dunst" "libnotify" "micro" "thunar" 
    "thunar-archive-plugin" "gvfs" "zoxide" "eza" "zsh" "btop" 
    "fastfetch" "grim" "slurp" "cliphist" "wl-clipboard" 
    "polkit-kde-agent" "network-manager-applet" "fontconfig" 
    "nwg-look" "ttf-jetbrains-mono-nerd" "hyprshot" "hyprpaper" 
    "hypridle" "hyprlock" "qt5-wayland" "qt6-wayland" "qt5ct"
    "zsh-autosuggestions" "zsh-syntax-highlighting" "mesa" 
    "wireplumber" "libgtop" "bluez" "bluez-utils" "networkmanager" 
    "dart-sass" "upower" "python" "pacman-contrib" 
    "power-profiles-daemon" "brightnessctl" "swww" "gtk3" "gtk4" 
    "libpulse" "adwaita-icon-theme" "ufw"
)

echo -e "\n${GREEN}🌐 Syncing missing dependencies...${NC}"
sudo pacman -S --needed --noconfirm "${PACMAN_APPS[@]}"

# --- 5. GPU Drivers Injection ---
echo -e "\n${GREEN}🎮 Configuring GPU Drivers...${NC}"
if echo "$GPU_LIST" | grep -iq "NVIDIA"; then
    sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils python-gpustat
elif echo "$GPU_LIST" | grep -iq "Intel"; then
    sudo pacman -S --needed --noconfirm vulkan-intel intel-media-driver
elif echo "$GPU_LIST" | grep -iq "AMD|ATI"; then
    sudo pacman -S --needed --noconfirm xf86-video-amdgpu vulkan-radeon
fi

# --- 6. AUR Section (Yay) ---
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}Yay not found. Installing now...${NC}"
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

AUR_APPS=(
    "bibata-cursor-theme-bin" "brave-browser-bin" "aylurs-gtk-shell-git"
    "ags-hyprpanel-git" "grimblast-git" "hyprpicker" "matugen-bin" 
    "hyprsunset-git" "gpu-screen-recorder-git"
)

echo -e "\n${GREEN}💎 Installing AUR packages...${NC}"
yay -S --needed --noconfirm "${AUR_APPS[@]}"

# --- 7. Post-Install (Zsh & UFW) ---
echo -e "\n${GREEN}🔧 Finalizing System...${NC}"
sudo systemctl enable --now ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw --force enable

[ "$SHELL" != "$(which zsh)" ] && sudo chsh -s "$(which zsh)" "$USER"

echo -e "\n${BLUE}🎉 LOONIX MASTER APPS INSTALLED!${NC}"