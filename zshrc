# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    git
    vi-mode
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
# Work Alias
if [ -e ~/.zshwork ]
then
    source ~/.zshwork
fi

# User configuration
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Keybinds
bindkey -v

# Alias
alias vim="nvim"
alias vvim="vim"
alias python='python3'
alias python2='python'
alias pip='pip3'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ndot='cd ~/.dotfiles/nvim/'

# tmux
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tmm='tmux new -s main'

# ceedee dot dot dot
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Functions
ckdir() {
  mkdir -p $1 && cd $1
}
