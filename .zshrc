## MACOS SPECIFICS

# zsh autosuggestions & syntax highlighting -wes

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# I think this has something to do with ssh'ing to/from outpost/gondor -wes
#export TERM=xterm-256color

# Use GNU 'ls' if available
if command -v gls &> /dev/null; then
  alias ls='gls --color=auto -l'
else
  alias ls='ls --color=auto -l'
fi

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/usr/local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/Users/wes/.local/share/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH=$PATH:$HOME/go/bin

set -o vi

#export EDITOR="/usr/local/bin/nvim"
export EDITOR="~/.local/share/bob/nightly/bin/nvim"

export PYMEMDYN="/Users/wes/Documents/code/pymemdyn"
export PATH=$PYMEMDYN:$PATH
export SCHRODINGER="/opt/schrodinger/suites2024-4"



## PROMPT SETTINGS

#PROMPT='[%n@%m %1~]$ '
#PROMPT='[%F{red}%n%F{yellow}@%m%f %1~]$ '
PROMPT='[%F{red}%n%f%F{15}@%F{yellow}%m%f %1~]$ '

LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"



## COLORS

# Enable color for 'ls'
autoload -U colors && colors

# Customize directory colors (e.g., bold blue)
export LS_COLORS="di=1;34"


# ALIASES

alias cf="cd ~/.config && ls -la"
alias ..="cd .."
alias cl="clear"
alias q="/Users/wes/Documents/code/scripts/quoter.sh"
alias t="tgpt -m"

# temp aliases on macOS until nvim 0.12 release
alias n="~/.local/share/bob/nightly/bin/nvim"
alias vim="~/.local/share/bob/nightly/bin/nvim"
alias nvim="~/.local/share/bob/nightly/bin/nvim"

# separate git management of dotfiles
# from yt/@semicolonsons https://www.youtube.com/watch?v=LI_Tv5dJkkk
alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" # separate git management of dotfiles

source <(fzf --zsh)

# Changes current working directory when exiting yazi (yy to start)
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# Auto-start tmux only if not already in tmux AND not in SSH
if [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]; then
  tmux attach -t 0 || tmux new -s 0
fi


