vim.o.guicursor=""
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.o.hidden = true
vim.o.errorbells = false
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.nu = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff=8
vim.o.signcolumn="yes"
vim.o.cmdheight=1
vim.o.colorcolumn="80"
vim.o.cursorline = true
vim.opt.completeopt={"menu","menuone","noselect"}

--	While the menu is active these keys have special meanings:
--
--	CTRL-Y		- accept the currently selected match and stop
--			  completion.
--	CTRL-E		- end completion, go back to what was there before
--			  selecting a match.
--	<Left> <Right>	- select previous/next match (like CTRL-P/CTRL-N)
--	<Down>		- in filename/menu name completion: move into a
--			  subdirectory or submenu.
--	<CR>		- in menu completion, when the cursor is just after a
--			  dot: move into a submenu.
--	<Up>		- in filename/menu name completion: move up into
--			  parent directory or parent menu.

vim.o.wildmenu = true
vim.o.wildmode = 'longest,list,full'

vim.opt.wildignore = {
    "*.pyc",
    "*_build/*",
    "**/coverage/*",
    "**/node_modules/*",
    "**/android/*",
    "**/ios/*",
    "**/.git/*"
}

vim.g.mapleader=" "
