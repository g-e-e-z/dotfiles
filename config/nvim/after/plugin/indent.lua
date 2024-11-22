local highlight = {
    "Red",
    "Green",
    "Yellow",
    "Blue",
    "Purple",
    "Aqua",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Red",       { fg = "#CC241D" })
    vim.api.nvim_set_hl(0, "Green",     { fg = "#98971A" })
    vim.api.nvim_set_hl(0, "Yellow",    { fg = "#D79921" })
    vim.api.nvim_set_hl(0, "Blue",      { fg = "#458588" })
    vim.api.nvim_set_hl(0, "Purple",    { fg = "#B16286" })
    vim.api.nvim_set_hl(0, "Aqua",      { fg = "#689D6A" })
    vim.api.nvim_set_hl(0, "Red",       { fg = "#CC241D" })
end)

require("ibl").setup { indent = { highlight = highlight } }
