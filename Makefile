DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

zsh: $(HOME)/.zshrc $(HOME)/.zsh_profile
tmux: $(HOME)/.tmux.conf
git: $(HOME)/.gitconfig $(HOME)/.githelpers # $(HOME)/.gitignore

alacritty:
	mkdir -p $(HOME)/.config/alacritty
	ln -sf $(DOTFILE_PATH)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

neovim:
	ln -sf "$(DOTFILE_PATH)/nvim" "$(HOME)/.config"

bins:
	ln -sf $(DOTFILE_PATH)/bin $(HOME)

all: zsh tmux alacritty neovim bins git

