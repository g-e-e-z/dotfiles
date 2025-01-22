-- opts
vim.opt.guicursor=""
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff=8
vim.opt.signcolumn="yes"
vim.opt.cmdheight=1
vim.opt.updatetime=50
vim.opt.colorcolumn="80"
vim.opt.cursorline = true
vim.opt.splitright=true
vim.opt.formatoptions="co"
vim.g.mapleader=" "
vim.opt.conceallevel = 2

-- remaps
vim.g.mapleader=" "
vim.keymap.set("n", "<leader>fd", require("oil").toggle_float)
vim.keymap.set("n", "<leader>fp", function() vim.cmd("vsplit | wincmd r") require("oil").open() end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n","J", "mzJ`z")

vim.keymap.set("n","<C-d>", "<C-d>zz")
vim.keymap.set("n","<C-u>", "<C-u>zz")

vim.keymap.set("n","n", "nzzzv")
vim.keymap.set("n","N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i","<C-c>", "<Esc>")

vim.keymap.set("n","Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

vim.keymap.set("n",'<leader>gd', ':vsplit | lua vim.lsp.buf.definition()<CR>')

vim.keymap.set("n","<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n","<leader>rn", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n","<leader>=", ":vertical resize +5<CR>")
vim.keymap.set("n","<leader>+", ":resize +5<CR>")
vim.keymap.set("n","<leader>-", ":vertical resize -5<CR>")
vim.keymap.set("n","<leader>_", ":resize -5<CR>")

vim.keymap.set("n","<S-Up>", "<cmd>m-2<CR>")
vim.keymap.set("n","<S-Down>", "<cmd>m+<CR>")

-- Autocmd
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local remove_white_group= augroup('RemoveWhite', {})
local yank_group = augroup('HighlightYank', {})

-- Highlight on Yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    desc="Highlight text being yanked.",
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove Trailing Whitespacec
autocmd("BufWritePre", {
    group = remove_white_group,
    pattern = "*",
    desc="Remove trailing white space on save",
    command = "%s/\\s\\+$//e",
})
