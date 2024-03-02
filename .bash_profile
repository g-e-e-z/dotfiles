export XDG_CONFIG_HOME="$HOME"/.config

# Only run on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  if [[ $(uname -m) == 'arm64' ]]; then
      # TODO: try to eliminate if else for M1/ Intel with prefix
      # Also refresh on what the below line actually does
      eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
      export PATH="$HOMEBREW_PREFIX/opt/postgresql@15/bin:$PATH"
  else
      eval "$(/usr/local/bin/brew shellenv)"
      eval "$(/usr/local/Homebrew/bin/brew shellenv)"
  fi
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

