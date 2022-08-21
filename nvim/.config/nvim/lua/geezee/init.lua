require("geezee.set")
require("geezee.packer")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local GeezeeGroup= augroup('Geezee', {})
local yank_group = augroup('HighlightYank', {})
local test_group = augroup('Test', {})

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

-- Print type of buffer on open
autocmd({"BufAdd"}, {
    group = test_group,
    pattern = "*/doc/*.txt",
    callback = function()
        print "HowdyHoeaaaa"
        vim.cmd('resize 30')
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
