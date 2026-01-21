-- NOTE: This isnt working, it requires nvchad
local statusline = require("config.statusline")

-- NOTE: Statusline
return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections = opts.sections or {}
			opts.sections.lualine_x = opts.sections.lualine_x or {}

			table.insert(opts.sections.lualine_x, statusline.clients)
			table.insert(opts.sections.lualine_x, statusline.python_venv)

			opts.always_show_tabline = false
		end,
	},
}
