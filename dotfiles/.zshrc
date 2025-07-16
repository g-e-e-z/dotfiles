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
export LAB="$GHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN="$HOME/second_brain"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/go"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"

# Needed for postgresql
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"

export VISUAL=nvim
export EDITOR=nvim

export MANPAGER="nvim +Man\!"

# ~~~~~~~~~~~~~~~ Path ~~~~~~~~~~~~~~~~~~~~~~~~
# export PATH="$PATH:$GOPATH" # GOPATH isnt defined here

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
setopt INC_APPEND_HISTORY

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

function git-prune-branches() {
        echo "switching to development.."
        git checkout development
        # git branch | grep 'main\|master' | xargs -n 1 git checkout
        echo "fetching with -p option...";
        git fetch -p;
        echo "running pruning of local branches"
        git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -D ;
}

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

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias dot='cd $GHREPOS/dotfiles'
alias lab='cd $GHREPOS/homelab'
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

# alias sv='sudoedit'
alias t='tmux attach || tmux new -s base'
alias e='exit'
alias sen='source .venv/bin/activate'

# git
alias gp='git push'
alias gl='git pull'
alias glog='git log -n 5 --graph --decorate --oneline'
alias gst='git status'
alias gcd='git checkout development'
alias gpb='git-prune-branches'
alias lg='lazygit'

# TODO: find a new home for these 2
# git config --global alias.co checkout
# git config --global alias.br branch

# docker
alias ldo='lazydocker'
alias dc='docker compose'
alias dcb='docker compose up --build'

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
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k

# terraform
alias tf='terraform'

alias tt='taskwarrior-tui'

# ~~~~~~~~~~~~~~~ Theme ~~~~~~~~~~~~~~~~~~~~~~~~
# Catpuccin
# export BAT_THEME="Catppuccin Frappe"
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#babbf1,fg+:#f4b8e4,prompt:#ca9ee6,hl+:#e78284 \
# --color=selected-bg:#51576d \
# --multi"

# Kanagawa Wave
# export FZF_DEFAULT_OPTS=" \
#   --color=bg+:#1F1F28,bg:#1F1F28,spinner:#DCA561,hl:#7E9CD8 \
#   --color=fg:#DCD7BA,header:#7FB4CA,info:#98BB6C,pointer:#C34043 \
#   --color=marker:#E82424,fg+:#DCD7BA,prompt:#957FB8,hl+:#7E9CD8\
#   --color=selected-bg:#C34043 \
#   --multi"

# gruvbox
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#282828,bg:#282828,spinner:#FE8019,hl:#83A598 \
  --color=fg:#D8D8D8,header:#8EC07C,info:#B8BB26,pointer:#FB4934 \
  --color=marker:#D75F5F,fg+:#D8D8D8,prompt:#D3869B,hl+:#83A598 \
  --color=selected-bg:#FB4934 \
  --multi"

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~
if test -f "$HOME/.privaterc"; then
    source "$HOME/.privaterc"
else
    echo "No .privaterc found"
fi

# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~
# Add custom and Homebrew completion directories
fpath+=~/.zfunc
fpath+=/opt/homebrew/share/zsh-completions

# Load completions
autoload -Uz compinit
compinit -u

# Enable selection UI for completions
zstyle ':completion:*' menu select

# fzf integration
# Load completion and key bindings from Homebrew FZF
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Load additional Homebrew-managed zsh completions
if [[ -r "/opt/homebrew/etc/profile.d/zsh_completion.sh" ]]; then
  source "/opt/homebrew/etc/profile.d/zsh_completion.sh"
fi

# Example: how to install completion manually
# talosctl completion zsh > "${fpath[1]}/_talosctl"
# TODO: This seems wrong, bash?
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /opt/homebrew/bin/terraform terraform

# ~~~~~~~~~~~~~~~ Autosuggestions & Highlighting ~~~~~~~~~~~~~~~~~~~~~~~~

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#665c54'
bindkey '^E' autosuggest-accept

# ~~~~~~~~~~~~~~~ Startup Dashboard ~~~~~~~~~~~~~~~~~~~~~~~~

# if [[ -o interactive ]]; then
#   if command -v task &>/dev/null; then
#     task list
#   fi
#
#   if command -v newsboat &>/dev/null; then
#     newsboat -x print-unread
#   fi
# fi

