-- NOTE: You can change these options as you wish!
--  See `:help vim.opt`
--  For more options, you can see `:help option-list`
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.opt.clipboard = "unnamedplus"
-- end)
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = false
vim.opt.smartcase = false
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 100
vim.opt.timeoutlen = 200
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.guicursor=""
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.o.termguicolors = true
vim.opt.cmdheight=1
vim.opt.colorcolumn="80"
vim.opt.formatoptions="co"
vim.opt.conceallevel=1
