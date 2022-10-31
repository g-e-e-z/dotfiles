DOTFILE_PATH := $(shell pwd)

$(HOME)/%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

zsh: $(HOME)/.zshrc $(HOME)/.zsh_profile
tmux: $(HOME)/.tmux.conf

alacritty:
	mkdir -p $(HOME)/.config/alacritty
	ln -sf $(DOTFILE_PATH)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml

neovim:
	ln -sf "$(DOTFILE_PATH)/nvim" "$(HOME)/.config"

bins:
	ln -sf $(DOTFILE_PATH)/bin $(HOME)

links: zsh tmux alacritty neovim bins

