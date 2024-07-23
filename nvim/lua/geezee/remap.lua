vim.g.mapleader=" "
-- vim.keymap.set("n", "<leader>pd", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>pd", require("oil").toggle_float)
vim.keymap.set("n", "<leader>pp", function() vim.cmd("vsplit | wincmd r") require("oil").open() end)

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
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n",'<leader>gd', ':vsplit | lua vim.lsp.buf.definition()<CR>')

-- Copilot
vim.api.nvim_set_keymap("i", "<C-E>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set("n","<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n","<leader>rn", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n","<leader>=", ":vertical resize +5<CR>")
vim.keymap.set("n","<leader>+", ":resize +5<CR>")
vim.keymap.set("n","<leader>-", ":vertical resize -5<CR>")
vim.keymap.set("n","<leader>_", ":resize -5<CR>")

vim.keymap.set("n","<S-Up>", "<cmd>m-2<CR>")
vim.keymap.set("n","<S-Down>", "<cmd>m+<CR>")

