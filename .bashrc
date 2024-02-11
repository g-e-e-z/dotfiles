# ~/.bashrc

export BASH_SILENCE_DEPRECATION_WARNING=1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Set to superior editing mode
set -o vi

# keybinds
# bind -x '"\C-l":clear'
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

# dotnet (unused)
# export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~ (figure out what this does)

include () {
    [[ -f "$1" ]] && source "$1"
}


# This function is stolen from rwxrob

# clone() {
# 	local repo="$1" user
# 	local repo="${repo#https://github.com/}"
# 	local repo="${repo#git@github.com:}"
# 	if [[ $repo =~ / ]]; then
# 		user="${repo%%/*}"
# 	else
# 		user="$GITUSER"
# 		[[ -z "$user" ]] && user="$USER"
# 	fi
# 	local name="${repo##*/}"
# 	local userd="$REPOS/github.com/$user"
# 	local path="$userd/$name"
# 	[[ -d "$path" ]] && cd "$path" && return
# 	mkdir -p "$userd"
# 	cd "$userd"
# 	echo gh repo clone "$user/$name" -- --recurse-submodule
# 	gh repo clone "$user/$name" -- --recurse-submodule
# 	cd "$name"
# } && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
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
# alias lab='cd $LAB'
# alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias cdgo='cd $GHREPOS/go/'
# alias rwdot='cd $REPOS/github.com/rwxrob/dot'
alias c="clear"
# alias icloud="cd \$ICLOUD"
# alias rob='cd $REPOS/github.com/rwxrob'
# alias homelab='cd $REPOS/github.com/mischavandenburg/homelab/'
# alias hl='homelab'
# alias hlp='cd $REPOS/github.com/mischavandenburg/homelab-private/'
# alias hlps='cd $REPOS/github.com/mischavandenburg/homelab-private-staging/'
# alias hlpp='cd $REPOS/github.com/mischavandenburg/homelab-private-production/'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

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

# ricing
# alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
# alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
# alias er='v ~/.config/awesome/rc.lua'
alias eb='v ~/.bashrc'
# alias ev='cd ~/.config/nvim/ && v init.lua'
# alias sz='source ~/.zshrc'
alias sbr='source ~/.bashrc'
# alias s='startx'

# vim & second brain
# alias sb="cd \$SECOND_BRAIN"
# alias in="cd \$SECOND_BRAIN/0-inbox/"
# alias vbn='python ~/git/python/brainfile.py'

# starting programmes
# alias cards='python3 /opt/homebrew/lib/python3.11/site-packages/mtg_proxy_printer/'

# terraform
# alias tp='terraform plan'

# fun
alias fishies=asciiquarium

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

# flux
# source <(flux completion bash)
# alias fgk='flux get kustomizations'

# talos
# source <(talosctl completion bash)

# EDB
# source <(kubectl-cnp completion bash)

# cilium
# source <(cilium completion bash)

# env variables
export VISUAL=nvim
export EDITOR=nvim

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# sourcing
source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
	# source "$HOME/.fzf.bash"
	# echo "I'm on Mac!"

	# brew bash completion
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
	# [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
