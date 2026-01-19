-- NOTE: Neovim Options

-- ====================================================================
-- Neovim Options Configuration
--  See `:help vim.o`
--  For more options, you can see `:help option-list`
-- ====================================================================

vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true -- Relative line numbers
vim.o.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.o.clipboard = "unnamedplus"
-- end)
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- TODO: ignore case and smartcase both false -> testing true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.updatetime = 100
vim.o.timeoutlen = 200
vim.o.splitright = true
vim.o.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
--vim.o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor.

vim.o.guicursor = ""
vim.o.hlsearch = false
vim.o.hidden = true
vim.o.errorbells = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.termguicolors = true
vim.o.cmdheight = 1
vim.o.colorcolumn = "80"
vim.o.formatoptions = "co"
vim.o.conceallevel = 1

-- ====================================================================
-- Extended options
-- ====================================================================

-- Customize fill characters (UI symbols for folds, end of buffer, etc.)
vim.opt.fillchars = {
	eob = " ", -- Empty line at the end of buffer
	fold = " ", -- Fill character for folded text
	foldopen = "", -- Icon for open fold
	foldsep = " ", -- Separator between folds
	foldclose = "", -- Icon for closed fold
	lastline = " ", -- Avoid ~ at the end of files
}

-- Append to 'shortmess' to reduce command line noise
-- 'A' = don't show swapfile messages, 'c' = suppress completion messages
vim.opt.shortmess:append("Ac")

-- Allow cursor to move freely between lines in Normal mode
vim.opt.whichwrap:append("<>[]hl")

-- Treat hyphenated words as a single word (for motions like 'w' and 'b')
vim.opt.iskeyword:append("-")

require("config.globals")
