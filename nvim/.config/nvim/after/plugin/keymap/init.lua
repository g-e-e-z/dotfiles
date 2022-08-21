local Remap = require("geezee.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap("<leader>pd", ":Ex<CR>")
nnoremap("<leader>pp", ":Vex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("<leader>y", '"*y')
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

inoremap("<C-c>", "<Esc>")
nnoremap("Q", "<nop>")

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
nnoremap("<leader>rn", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

nnoremap("<leader>=", ":vertical resize +5<CR>")
nnoremap("<leader>-", ":vertical resize -5<CR>")

nnoremap("<S-Up>", "<cmd>m-2<CR>")
nnoremap("<S-Down>", "<cmd>m+<CR>")
