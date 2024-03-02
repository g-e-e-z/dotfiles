# ~/.bashrc

export BASH_SILENCE_DEPRECATION_WARNING=1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
# config
export BROWSER="chrome"

# directories
export REPOS="$HOME/Repos"
export GITUSER="g-e-e-z"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
# export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ICLOUD="$HOME/icloud"
# export SECOND_BRAIN="$HOME/garden"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
#
# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~ Figure this out
# SSH Script from arch wiki

# if ! pgrep -u "$USER" ssh-agent >/dev/null; then
# 	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
# 	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Only run on Ubuntu
#
# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# fi

# adding keys was buggy, add them outside of the script for now (unused)
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg
#{
# ssh-add -q ~/.ssh/id_ed25519
# ssh-add -q ~/.ssh/vanoord
#} &>/dev/null

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWUPSTREAM="auto git"

if [[ -f "$XDG_CONFIG_HOME/bash/gitprompt.sh" ]]; then
	source "$XDG_CONFIG_HOME/bash/gitprompt.sh"
fi
if [[ -f "$XDG_CONFIG_HOME/bash/git-prompt.sh" ]]; then
	source "$XDG_CONFIG_HOME/bash/git-prompt.sh"
fi

# colorized prompt
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\]" " \n$ "'

# The __git_ps1 function prompt is provided by the bash completion installed by brew. See https://github.com/mischavandenburg/dotfiles/issues/5

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
# alias cdblog="cd ~/websites/blog"
# alias cdpblog='cd $SECOND_BRAIN/2-areas/blog/content'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias cdgo='cd $GHREPOS/go/'
alias c="clear"

alias python2='python'
alias python='python3'

# ls
alias ls='eza --color=auto'
alias ll='eza -la'
alias la='eza -lahr'
alias tree='eza -TL'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.bashrc'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# git
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias lg='lazygit'
git config --global alias.co checkout
git config --global alias.br branch

# docker
alias dc='docker compose'

# ricing
alias ebr='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && vim lua/geezee/packer.lua'  # Refactor nvim later
alias sbr='source ~/.bashrc'

# vim & second brain
# alias sb="cd \$SECOND_BRAIN"
# alias in="cd \$SECOND_BRAIN/0-inbox/"
# alias vbn='python ~/git/python/brainfile.py'

# terraform
# alias tp='terraform plan'

# kubectl
# alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k
# alias kgp='kubectl get pods'
# alias kc='kubectx'
# alias kn='kubens'
#
# alias kcs='kubectl config use-context admin@homelab-staging'
# alias kcp='kubectl config use-context admin@homelab-production'

# EDB
# source <(kubectl-cnp completion bash)

# env variables
export VISUAL=nvim
export EDITOR=nvim

# sourcing
source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # echo "macOS detected"
    if [[ $(uname -m) == 'arm64' ]]; then
        # echo "M1"
        # TODO: Modify intel to use the prefix and eliminate if/else if possible
        source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.bash"
        source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.bash"
        # brew bash completion: TODO: What is this syntax below actually doing
        [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    else
        # echo "Intel"
        source "/usr/local/Cellar/fzf/0.46.1/shell/completion.bash"
        source "/usr/local/Cellar/fzf/0.46.1/shell/key-bindings.bash"
        # brew bash completion
        [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
    fi

else
    #	Figure this out when I start using a Linux machine
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
