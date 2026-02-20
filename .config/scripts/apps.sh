#!/bin/bash

# =========================================================
#  LOONIX - MASTER INSTALLATION SCRIPT
# =========================================================

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
sleep 2

echo "--- Installing Comprehensive App List ---"

# =========================================================
#  PART 1: PACMAN PACKAGES (Official Repos)
# =========================================================

PACMAN_APPS=(
    # --- Base System ---
    "limine" "sddm" "hyprland" "xdg-desktop-portal-hyprland" "uwsm" 
    "kitty" "wofi" "dunst" "libnotify"
    
    # --- Apps & Utilities ---
    "micro" "thunar" "thunar-archive-plugin" "gvfs" 
    "zoxide" "eza" "zsh" "btop" "fastfetch"
    
    # --- Screenshot & Clipboard ---
    "grim" "slurp" "cliphist" "wl-clipboard" 
    "polkit-kde-agent" "network-manager-applet"
    
    # --- Themes & Fonts ---
    "ttf-nerd-fonts-symbols" "fontconfig" "nwg-look" 
    "ttf-jetbrains-mono-nerd"  # Font for icons
    
    # --- Hyprland Ecosystem ---
    "hyprshot" "hyprpaper" "hypridle" "hyprlock"
    
    # --- Qt & Wayland ---
    "qt5-wayland" "qt6-wayland" "qt5ct"
    
    # --- Shell & Plugins ---
    "zsh-autosuggestions" "zsh-syntax-highlighting"
    
    # --- Drivers & Hardware ---
    "mesa" 
    
    # --- Firewall ---
    "ufw"
    
    # --- HyprPanel Core Dependencies ---
    "wireplumber"
    "libgtop"
    "bluez"
    "bluez-utils"
    "networkmanager"
    "dart-sass"
    "upower"
    "gvfs"
    "python"
    "pacman-contrib"
    "power-profiles-daemon"
    
    # --- Optional but Recommended ---
    "brightnessctl"       # Brightness control
    "swww"                # Wallpaper manager for matugen
    "python-gpustat"      # GPU monitoring (for NVIDIA)
    
    # --- System Libraries ---
    "gtk3" "gtk4" "libpulse" "adwaita-icon-theme"
)

echo "📦 Installing Pacman packages..."
sudo pacman -S --needed "${PACMAN_APPS[@]}" --noconfirm

# =========================================================
#  PART 2: YAY BOOTSTRAPPING
# =========================================================

if ! command -v yay &> /dev/null; then
    echo "📦 Yay not found. Installing now..."
    sudo pacman -S --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf /tmp/yay
fi

# =========================================================
#  PART 3: AUR PACKAGES
# =========================================================

AUR_APPS=(
    # --- Cursor & Themes ---
    "bibata-cursor-theme-bin"
    
    # --- Browser ---
    "brave-browser-bin"
    
    # --- HyprPanel Core (AGS based) ---
    "aylurs-gtk-shell-git"        # Core AGS (required by HyprPanel)
    "ags-hyprpanel-git"            # HyprPanel itself
    
    # --- HyprPanel Tools & Dependencies ---
    "grimblast-git"                 # Screenshot for dashboard
    "hyprpicker"                    # Color picker
    "matugen-bin"                   # Color theming
    "hyprsunset-git"                 # Blue light filter
    "hypridle-git"                   # Idle inhibitor
    
    # --- Optional but Useful ---
    "gpu-screen-recorder-git"       # Screen recording
)
# Add NVIDIA drivers if detected
if echo "$GPU_LIST" | grep -iq "NVIDIA"; then
    echo "-> NVIDIA detected, adding nvidia-dkms and nvidia-utils"
    sudo pacman -S --needed nvidia-dkms nvidia-utils --noconfirm
    # python-gpustat already added in pacman section
fi

# Add Intel drivers if detected
if echo "$GPU_LIST" | grep -iq "Intel"; then
    echo "-> Intel detected, adding vulkan-intel intel-media-driver"
    sudo pacman -S --needed vulkan-intel intel-media-driver --noconfirm
fi

# Add AMD drivers if detected
if echo "$GPU_LIST" | grep -iq "AMD|ATI"; then
    echo "-> AMD detected, adding xf86-video-amdgpu vulkan-radeon"
    sudo pacman -S --needed xf86-video-amdgpu vulkan-radeon --noconfirm
fi

echo "📦 Installing AUR packages..."
yay -S --needed "${AUR_APPS[@]}" --noconfirm

# =========================================================
#  PART 4: CHANGE DEFAULT SHELL TO ZSH
# =========================================================

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔧 Changing default shell to zsh..."
    sudo chsh -s $(which zsh) $USER
fi

# =========================================================
#  PART 5: FIREWALL CONFIGURATION
# =========================================================

echo "🔒 Configuring Firewall..."

# Enable and start UFW service
sudo systemctl enable --now ufw

# Set default policies: Deny all incoming, Allow all outgoing
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow common essential ports (optional)
# sudo ufw allow ssh

# Activate the firewall
sudo ufw --force enable

echo "✅ Firewall is now ACTIVE and will start on boot."

# =========================================================
#  PART 6: HYPRPANEL POST-INSTALL NOTES
# =========================================================

echo ""
echo "🎉 ===== INSTALLATION COMPLETE ===== 🎉"
echo ""

