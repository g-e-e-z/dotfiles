require("geezee.set")
require("geezee.packer")

local augroup = vim.api.nvim_create_augroup
GeezeeGroup= augroup('Geezee', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- Highlight on Yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove Trailing Whitespacec
autocmd({"BufWritePre"}, {
    group = GeezeeGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

