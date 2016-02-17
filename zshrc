# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="pure"

plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
#
export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source  ~/.oh-my-zsh/syntax_highlighting/zsh-syntax-highlighting.zsh

export PATH=$HOME/dotfiles/bin:$PATH

# aliases
alias cls="clear && ls"
alias gs="git status"
alias e="thunar"
alias tmux="TERM=screen-256color-bce tmux "
alias tat="TERM=screen-256color-bce tmux attach -t `basename $PWD`"
