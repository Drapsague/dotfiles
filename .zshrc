# oh my posh config for default terminal
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Shell integrations
eval "$(fzf --zsh)"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -Uz compinit && compinit

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Completion styling
zstyle ':competion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

alias ls="ls --color"
alias ff="fzf"
alias icat="kitten icat"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias vmrun="/Applications/VMware\ Fusion.app/Contents/Library/vmrun"

# Created by `pipx` on 2025-04-23 10:44:11
export PATH="$PATH:/Users/edualc/.local/bin"
export DOCKER_HOST=unix:///Users/$USER/.orbstack/run/docker.sock

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v17)
