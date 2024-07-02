export XDG_CONFIG_HOME="$HOME"/.config

eval "$(/opt/homebrew/bin/brew shellenv)"

# Only run on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="opt/homebrew/opt/postgresql@15/bin:$PATH"
fi


if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="/usr/local/opt/ruby/bin:$PATH"

