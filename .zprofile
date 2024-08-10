export XDG_CONFIG_HOME="$HOME"/.config

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -r ~/.zshrc ]; then
  source ~/.zshrc
fi
