#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/personal ~/work ~/.dotfiles -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

echo "---- > $selected_name"

# Assures order is correct
tmux move-window -t 0

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-window -n $selected_name -c $selected
    exit 0
fi
#
if ! tmux has-window-t=$selected_name 2> /dev/null; then
    tmux new-window -n $selected_name -c $selected
fi

