# export XDG_CONFIG_HOME="$HOME"/.config
#
# eval "$(/opt/homebrew/bin/brew shellenv)"
if which newsboat >/dev/null; then
    newsboat -x print-unread
fi
if which task >/dev/null; then
    task list
fi

if [ -r ~/.zshrc ]; then
  source ~/.zshrc
fi
