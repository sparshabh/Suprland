# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
alias i="yay -S"
alias r="yay -Rns"
alias u="yay -Syu"

# Script/Command Aliases
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias waybar-restart="~/.config/waybar/scripts/launch.sh"
alias startup="~/.config/supr/scripts/startup.sh"
alias wallswitch="~/.config/supr/scripts/wallswitch.sh"
alias gamemode="~/.config/supr/scripts/gamemode.sh"

# Config Aliases
alias hypr-config="nvim .config/hypr/"
alias kitty-config="nvim .config/kitty/kitty.conf"
alias rofi-config="nvim .config/rofi/config.rasi"
alias waybar-config="nvim .config/waybar/"
alias wlogout-config="nvim .config/wlogout/"

alias matugen-config="nvim .config/matugen/config.toml"
alias neovim-config="nvim .config/nvim/"
alias gtk3-config="nvim .config/gtk-3.0/gtk.css"
alias gtk4-config="nvim .config/gtk-4.0/gtk.css"

# Util Aliases
alias info="clear && fastfetch"
alias clock="tty-clock -c -t -n"
alias matrix="cmatrix"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PATH=$PATH:/home/sparsha/.spicetify
export PATH=$PATH:$HOME/.spicetify
export PATH="$HOME/.local/bin:$PATH"
