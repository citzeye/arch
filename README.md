🐧 Arch Linux Dotfiles - citzeye

Welcome to my configuration repository! This repo contains my personal Arch Linux dotfiles, crafted with a focus on clean aesthetics and a fast, efficient workflow.

## 🛠️ TECH STACK
 - WM: Hyprland (Wayland)
 - Terminal: Kitty
 - Shell: Zsh (with Powerlevel10k/Oh-My-Zsh)
 - File Manager: Thunar
 - Editor: Micro / VS Code



## 🚀 QUICK INSTALLATION
If you're feeling brave (use at your own risk!), simply clone and copy the configs:

    git clone https://github.com/citzeye/arch.git
    cd arch
    chmod +x citzinstall.sh
    ./citzinstall.sh


> ## Note :
> *I asume you have been installed ARCH base with no GUI.* This is online install not offline. Thats mean you need INTERNET CONNECTION
> You can use usb tethering from your phone if you dont have wired
> internet/driver for your wifi dongle.*
> 
> Test your connection with : ping google.com" (press 'ctrl+c' to stop
> ping)



## ⌨️ Keybindings
| Category | Keybind | Function |
| :--- | :--- | :--- |
| Apps | Super + Enter | Terminal (Kitty) |
| Apps | Super + B | Browser (Brave) |
| Apps | Super + E | File Manager (Thunar) |
| Apps | Super + Space | App Launcher (Wofi) |
| Apps | Super + V | Clipboard History |
| Apps | Alt + C | Edit Config (VS Code) |
| Window | Alt + Q | Close Window (Kill) |
| Window | Super + T | Toggle Floating |
| Window | Super + F | Fullscreen |
| Window | Super + Arrow | Move Focus |
| System | Super + M | Exit Hyprland |
| System | Super + Home | Reload All Configs |
| System | Ctrl + Shift + R | Sapu Jagat (Total Refresh) |
| Screen | Super + Print | Screenshot Region |
| Screen | Print | Screenshot Fullscreen |
| Workspc | Alt + [1-5] | Switch Workspace |
| Workspc | Super + [1-5] | Move Window to Workspace |
| Workspc | Alt + Tab | Next Workspace |



## ⚡ Essential Aliases
| Alias | File to Edit |
| :--- | :--- |
| ch | Hyprland Main Config |
| ckeybinds| Keybindings Config |
| czsh | Zsh Runtime Config |
| ckit | Kitty Terminal Config |
| cway | Waybar Layout/Config |
| cwaycss | Waybar CSS Styling |



## 🛠️ System & Workflow
| Alias | Function |
| :--- | :--- |
| nuke | TOTAL REFRESH: Reload Zsh + Reset All GUI |
| rzsh | Reload Zsh Only |
| gitpush| Auto Add, Commit ("update"), & Push |
| c | Jump to ~/.config |
| update | Update System (pacman -Syu) |
| spi / spr| Install / Remove Package |
| dsync | Sync script for .desktop files |



Built with ☕ and the **headache** of configuring Waybar.

