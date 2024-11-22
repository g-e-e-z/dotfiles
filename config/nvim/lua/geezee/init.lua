require("geezee.remap")
require("geezee.set")
require("geezee.packer")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local GeezeeGroup= augroup('Geezee', {})
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
    group = GeezeeGroup,
    pattern = "*",
    desc="Remove trailing white space on save",
    command = "%s/\\s\\+$//e",
})
