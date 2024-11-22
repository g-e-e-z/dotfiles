-- Enable spellchecking and automatically wrap at 80 characters for markdown files
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "markdown",
    callback = function()
        vim.bo.spell = true
        vim.bo.textwidth = 80
    end,
})
