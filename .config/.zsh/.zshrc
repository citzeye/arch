# =========================================================
#  ZSH CONFIGURATION
# =========================================================

# --- 1. Environment Variables ---
export EDITOR='micro'
export VISUAL='micro'
export ZSH="$HOME/.oh-my-zsh"

# --- 2. Oh My Zsh Setup (Urutan jangan ditukar!) ---
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh (Taruh paling bawah setelah theme & plugins)
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh


# --- 3. History & Behavior ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt share_history
setopt autocd

# --- 4. Completion ---
autoload -Uz compinit
compinit -i

# --- 5. Aliases: Navigation ---
alias z='cd'
alias c='cd ~/.config'
alias ..='cd ..'
alias ...='cd ../..'

# --- 6. Aliases: Hyprland Configs (The Core) ---
alias ch='micro ~/.config/hypr/hyprland.conf'
alias ccolors='micro ~/.config/hypr/colors.conf'
alias cidle='micro ~/.config/hypr/hypridle.conf'
alias clock='micro ~/.config/hypr/hyprlock.conf'
alias cpaper='micro ~/.config/hypr/hyprpaper.conf'
alias cenv='micro ~/.config/hypr/configs/env.conf'
alias cexec='micro ~/.config/hypr/configs/exec.conf'
alias ckeybinds='micro ~/.config/hypr/configs/keybinds.conf'
alias crules='micro ~/.config/hypr/configs/rules.conf'

# --- 7. Aliases: Apps & Shell ---
alias ckit='micro ~/.config/kitty/kitty.conf'
alias cway='micro ~/.config/waybar/config.jsonc'
alias cwaycss='micro ~/.config/waybar/style.css'
alias czsh='micro ~/.zshrc'
alias rzsh='source ~/.zshrc && echo "🚀 Zsh Config Reloaded!"'
alias nuke='source ~/.zshrc && r-all && echo "Reload all config DONE!"'
alias dsync='cd ~/.desktop && ./sync.sh && cd -'
alias gitpush='git add . && git commit -m "update" && git push'

# --- 8. Aliases: Package Manager (Arch Life) ---
alias update='sudo pacman -Syu'
alias spi='sudo pacman -S'
alias spr='sudo pacman -Rs'
alias ls='ls -la --color=auto'
alias la='ls -a'


# --- 9. Custom Functions ---
mkd() { mkdir -p "$@" && cd "$_"; }

# =========================================================
#  END OF CONFIG
# =========================================================
