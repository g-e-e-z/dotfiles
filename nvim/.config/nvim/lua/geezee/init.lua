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

-- Bigger help window
autocmd("BufAdd", {
    group = GeezeeGroup,
    pattern = "*/doc/*.txt",
    desc="Make the help window larger",
    callback = function()
        vim.cmd('resize 30')
    end
})

--[[ local test_group = augroup('Test', {})
    autocmd("FileType", {
    pattern = "text",
    group = test_group,
    desc = "print file info",
    callback = function()
        local data = {
            buf = vim.fn.expand("<abuf>"),
            file = vim.fn.expand("<afile>"),
            match = vim.fn.expand("<amatch>"),
        }

        vim.schedule(function()
            print("Getting Called")
            print(vim.inspect(data))
        end)
    end
}) ]]

vim.g.netrw_browse_split = 0
