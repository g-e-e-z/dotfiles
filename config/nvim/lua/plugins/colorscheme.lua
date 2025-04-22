-- NOTE: You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
    -- name = "catppuccin",
    -- "catppuccin/nvim",
    -- "rebelot/kanagawa.nvim",
    -- name = "kanagawa",
	"sainnhe/gruvbox-material",
	-- name = "gruvbox",
    lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd.colorscheme "gruvbox-material"
        -- vim.cmd.colorscheme "catppuccin-frappe"
        -- vim.cmd.colorscheme "kanagawa dragon"
        -- vim.cmd.colorscheme "kanagawa"

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
}
