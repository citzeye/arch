# =========================================================
#  ZSH CONFIGURATION (LOONIX MASTER)
# =========================================================

# --- 1. Environment Variables ---
export EDITOR='micro'
export VISUAL='micro'

# Fix untuk AGS dan aplikasi GTK
export XDG_RUNTIME_DIR=/run/user/$UID
export PATH="$HOME/.config/scripts:$HOME/.config/locals/bin:$PATH"

# --- 2. Simple Prompt Setup ---
#PROMPT='%F{cyan}%n@%m%f >
#'

# Not simple prompt
	get_breadcrumb() {
	  local path_str="${PWD/#$HOME/󰋜 }"
	  # Filter supaya kalau di root atau awal gak double pipe
	  local formatted="${path_str//\// | }"
	  echo "${formatted} |"
	}

	setopt prompt_subst

# GANTI INI: Pakai double quotes agar variabel lari saat shell mulai
# Dan kita pakai precmd supaya dia update SETIAP KALI lo enter/pindah folder
set_prompt() {
    PROMPT="%F{blue}%n@%m%f | %F{cyan}$(get_breadcrumb)%f %F{green}>%f
"su
}
precmd_functions+=(set_prompt)

# --- Cursor Setup (Underline) ---
_set_cursor() { echo -ne "\e[4 q"; }
precmd_functions+=(_set_cursor)
_set_cursor

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
alias ,='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias c='cd ~/loonix/.config'
alias l='cd ~/loonix'
alias ltlg='cd ~/loonix/tools/loonix-gui'
alias ltll='cd ~/loonix/tools/loonix-login'
alias s='cd ~/loonix/.config/scripts'
alias t='cd ~/loonix/tools'
#alias z='cd'


# --- 6. Aliases: Hyprland Configs (Target: Loonix Folder) ---
alias chypr='micro ~/loonix/.config/hypr/hyprland.conf'
alias ccolors='micro ~/loonix/.config/hypr/colors.conf'
alias cidle='micro ~/loonix/.config/hypr/hypridle.conf'
alias clock='micro ~/loonix/.config/hypr/hyprlock.conf'
alias cpaper='micro ~/loonix/.config/hypr/hyprpaper.conf'
alias cenv='micro ~/loonix/.config/hypr/configs/env.conf'
alias cexec='micro ~/loonix/.config/hypr/configs/exec.conf'
alias ckeybinds='micro ~/loonix/.config/hypr/configs/keybinds.conf'
alias crules='micro ~/loonix/.config/hypr/configs/rules.conf'
	# HYPRPANEL ALIASES ---
	alias cpanel='micro ~/loonix/.config/hyprpanel/config.json'
	alias copanel='micro ~/loonix/.config/hyprpanel/options.json'

# --- 7. Aliases: Apps & Shell ---
alias ckit='micro ~/loonix/.config/kitty/kitty.conf'
alias cway='micro ~/loonix/.config/waybar/config.jsonc'
alias cwaycss='micro ~/loonix/.config/waybar/style.css'
alias czsh='micro ~/loonix/.config/zshs/.zshrc'
alias rzsh='source ~/.zshrc && echo "🚀 Zsh Config Reloaded!"'
alias nuke='/home/citz/loonix/.config/scripts/r-all.sh'

alias gogit='cd ~/loonix && git add . && git commit -m "update" && git push && cd -'

# --- 8. Aliases: Package Manager ---
alias update='sudo pacman -Syu'
alias spi='sudo pacman -S'
alias spr='sudo pacman -Rs'
alias ls='ls -la --color=auto'
alias la='ls -a'

# --- 9. Custom Functions ---
mkd() { mkdir -p "$@" && cd "$_"; }

# --- 10. Plugins (Arch Linux Path) ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# --- 11. Custom Functions ---

# =========================================================
eval "$(zoxide init zsh)"
#  END OF CONFIG
# =========================================================
