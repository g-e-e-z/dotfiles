local O = vim.o
local G = vim.g


O.guicursor=""
O.relativenumber = true
O.hlsearch = false
O.hidden = true
O.errorbells = false
O.tabstop=4
O.softtabstop=4
O.shiftwidth=4
O.expandtab = true
O.smartindent = true
O.nu = true
O.wrap = false
O.swapfile = false
O.backup = false
O.undodir = os.getenv("HOME") .. "/.vim/undodir"
O.undofile = true
O.incsearch = true
O.termguicolors = true
O.scrolloff=8
O.signcolumn="yes"
O.cmdheight=1
O.colorcolumn="80"
O.cursorline = true

G.mapleader=" "

O.background = "dark"
