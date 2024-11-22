DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
export N_PREFIX = $(HOME)/.n
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(N_PREFIX)/bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/zsh
SHELLS := /private/etc/shells
BIN := $(HOMEBREW_PREFIX)/bin
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

# macos: sudo core-macos packages link duti
macos: core-macos packages link

linux: core-linux link

core-macos: brew zsh git

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

packages: brew-packages cask-apps # node-packages rust-packages TODO: add python management

link: stow-$(OS)
	for FILE in $$(\ls -A dotfiles); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(HOME)" dotfiles
	stow -t "$(XDG_CONFIG_HOME)" config
	# mkdir -p $(HOME)/.local/runtime
	# chmod 700 $(HOME)/.local/runtime

unlink: stow-$(OS)
	stow --delete -t "$(HOME)" dotfiles
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | zsh

zsh: brew
	if ! grep -q zsh $(SHELLS); then \
		brew install zsh && \
		sudo append $(shell which zsh) $(SHELLS) && \
		chsh -s $(shell which zsh); \
	fi

git: brew
	brew install git #git-extras TODO: this

brew-packages: brew
	xargs brew install $(DOTFILES_DIR)/install/brew.txt || true

cask-apps: brew
	xargs brew install --cask $(DOTFILES_DIR)/install/cask.txt || true
