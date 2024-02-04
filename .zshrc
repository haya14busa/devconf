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

# Enable command completion system
autoload -Uz compinit
compinit

# Eval
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(sheldon source)"

# PATH
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

# source
source "$HOME/.cargo/env"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh