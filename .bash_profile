export BASH_SILENCE_DEPRECATION_WARNING=1
export XDG_CONFIG_HOME="$HOME"/.config

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi
