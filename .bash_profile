export XDG_CONFIG_HOME="$HOME"/.config

# Only run on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  # Also refresh on what the below line actually does
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
  export PATH="$HOMEBREW_PREFIX/opt/postgresql@15/bin:$PATH"
fi

# # Only run these on Ubuntu
# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
#   # needed for brew to work
#   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

