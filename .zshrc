# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Functions
function exists { which $1 &> /dev/null }

# Improve history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory # Append history instead of overwriting it
setopt sharehistory # Share history across terminals
setopt incappendhistory # Immediately append to the history file, not just when the shell exits

setopt nocorrectall # Disable correction
setopt interactive_comments # Allow `#` comment
bindkey -e # Emacs-style keybinding

# Enable command completion system
autoload -Uz compinit
compinit

# PATH
export PATH="${HOME}/bin:$PATH"
export PATH="${HOME}/.local/bin:$PATH"
if exists go; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${HOME}/go/bin:$PATH"
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

# export
export EDITOR=$(which vim)
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml

# source
source "$HOME/.cargo/env"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Alias
## lsd - https://github.com/lsd-rs/lsd
if exists lsd; then
  alias ls='lsd'
fi
alias l='ls -l'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias lta='ls -a --tree'

# https://github.com/sharkdp/bat?tab=readme-ov-file#highlighting---help-messages
alias bathelp='bat --plain --language=help'
help() {
  "$@" --help 2>&1 | bathelp
}
# alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# FZF
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "lsd -a --color=always --icon=always $(ghq root)/{}")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^o' ghq-fzf

# Eval
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if exists sheldon; then
  eval "$(sheldon source)"
fi
if exists zoxide; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Load local .zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.key ] && source ~/.zshrc.key

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
