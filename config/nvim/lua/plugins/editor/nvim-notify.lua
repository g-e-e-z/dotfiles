-- NOTE: Notification
return {
	"rcarriga/nvim-notify",
	lazy = false,
	event = "VeryLazy",
	opts = {
		level = 1,
		minimum_width = 35,
		render = "default",
		stages = "fade_in_slide_out",
		timeout = 2000,
		top_down = false,
		background_color = "#000000",
	},
	config = function(_, opts)
		require("notify").setup(opts)

		vim.notify = require("notify")
        -- Hack to avoid annoying bug, set false here lazy/nvim-notify/lua/notify/config/init.lua"
	end,
}
