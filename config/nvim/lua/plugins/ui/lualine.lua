-- NOTE: This isnt working, it requires nvchad
local statusline = require("config.statusline")

-- NOTE: Statusline
return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		opts = function(_, opts)
			opts.sections = opts.sections or {}
			opts.sections.lualine_x = opts.sections.lualine_x or {}

			table.insert(opts.sections.lualine_x, statusline.clients)
			table.insert(opts.sections.lualine_x, statusline.python_venv)

			opts.always_show_tabline = false

			opts.sections.lualine_c = opts.sections.lualine_c or {}
			local harpoon = {
				"harpoon2",
				icon = "󰀱 ",
				indicators = { "h", "j", "k", "l" },
				active_indicators = { "[H]", "[J]", "[K]", "[L]" },
				color_active = { fg = "#7da6ff" },
				_separator = " ",
				no_harpoon = "Harpoon not loaded",
			}

			table.insert(opts.sections.lualine_c, harpoon)
		end,
	},
}
