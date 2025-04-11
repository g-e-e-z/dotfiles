# ~/.zshrc
export XDG_CONFIG_HOME="$HOME/.config"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable Zsh's extended globbing and null_glob options
setopt extended_glob null_glob
setopt inc_append_history

bindkey -v

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
export BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"


# directories
export REPOS="$HOME/Repos"
export GITUSER="g-e-e-z"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
# export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN="$HOME/second_brain"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"

# Needed for postgresql
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"

export VISUAL=nvim
export EDITOR=nvim

# ~~~~~~~~~~~~~~~ Path ~~~~~~~~~~~~~~~~~~~~~~~~
export PATH="$SCRIPTS:$PATH:$GOPATH"

pathappend() {
    local arg
    for arg in "$@"; do
        test -d "$arg" || continue
        PATH=${PATH//":$arg:"/:}
        PATH=${PATH/#"$arg:"/}
        PATH=${PATH/%":$arg"/}
        export PATH="${PATH:+"$PATH:"}$arg"
    done
}

pathprepend() {
    local arg
    for arg in "$@"; do
        test -d "$arg" || continue
        PATH=${PATH//:"$arg:"/:}
        PATH=${PATH/#"$arg:"/}
        PATH=${PATH/%":$arg"/}
        export PATH="$arg${PATH:+":${PATH}"}"
    done
}

# remember last arg will be first in path
pathprepend \
	"$HOME/.local/bin" \
	"$HOME/.local/go/bin" \
    "$HOME/.cargo/bin" \
	"$HOME/.nimble/bin" \
	/usr/local/go/bin \
	/usr/local/bin \
    /opt/homebrew/bin \
    /opt/homebrew/opt/postgresql@15/bin \
	"$SCRIPTS"

pathappend \
	/usr/local/opt/coreutils/libexec/gnubin \
	/usr/local/bin \
	/usr/local/sbin \
    /opt/homebrew/opt/ruby/bin \
    /opt/homebrew/opt/libpq/bin \
	/usr/local/games \
	/usr/games \
	/usr/sbin \
	/usr/bin \
	/snap/bin \
	/sbin \
	/bin


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
# TODO: Figure this out
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
# alias sk='killall ssh-agent && source ~/.zshrc'

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"
eval "$(starship preset pure-preset -o ~/.config/starship.toml)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle :prompt:pure:path color '#d79921'
zstyle :prompt:pure:git:branch color '#458588'
zstyle :prompt:pure:git:dirty color '#cc241d'
zstyle :prompt:pure:git:action color '#cc241d'

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias cdgo='cd $GHREPOS/go/'
alias c="clear"

alias python2='python'
alias python='python3'

# ls
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alFh'
alias ls='ls --color=auto'

alias tree='tree -C'

alias cat='bat --paging=never'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'

# git
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias gcd='git checkout development'
alias lg='lazygit'
# TODO: find a new home for these 2
git config --global alias.co checkout
git config --global alias.br branch

# docker
alias ldo='lazydocker'
alias dc='docker compose'
alias dcb='docker compose up --build'

# gcloud
alias gproj='gcloud config get-value project'

alias ez='v ~/.zshrc'
alias sz='source ~/.zshrc'

alias sed='gsed'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="pushd .> /dev/null; cd \$SECOND_BRAIN/inbox/"

# newsboat
alias nb="newsboat"
alias nbu="newsboat -x print-unread"

# kubectl
alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
# alias kc='kubectx'
# alias kn='kubens'

alias tt='taskwarrior-tui'

# ~~~~~~~~~~~~~~~ Theme ~~~~~~~~~~~~~~~~~~~~~~~~
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#f4b8e4,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"

export BAT_THEME="Catppuccin Frappe"

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~
if test -f "$HOME/.privaterc"; then
    source "$HOME/.privaterc"
else
    echo "No .privaterc found"
fi

# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~

fpath+=~/.zfunc

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select

# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl


if [[ "$OSTYPE" == "darwin"* ]]; then
    source /opt/homebrew/opt/fzf/shell/completion.zsh
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    # brew zsh completion: TODO: What is this syntax below actually doing
    [[ -r ""/opt/homebrew/etc/profile.d/zsh_completion.sh"" ]] && . "/opt/homebrew/etc/profile.d/zsh_completion.sh"

else
    #	Figure this out when I start using a Linux machine
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
