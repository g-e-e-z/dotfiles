-- NOTE: File explorer like vim-vinegar
return {
	"stevearc/oil.nvim",
	lazy = false,
	init = function()
		-- vim.keymap.set("n", "<leader>O", function()
		vim.keymap.set("n", "-", function()
			vim.cmd("Oil --float --preview")
			-- if vim.bo.filetype == "oil" then
			-- 	vim.cmd(":q")
			-- else
			-- 	vim.cmd("Oil --float")
			-- end
		end, { desc = "Oil | Toggle Oil" })
	end,
	cmd = "Oil",
	opts = {
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = false,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = 2,
			max_height = math.ceil(vim.o.lines * 0.9 - 4),
			max_width = math.ceil(vim.o.columns * 0.8),
			border = "rounded",
			preview_split = "auto",
			win_options = {
				winblend = 0,
			},
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-k>"] = false,
			["<C-j>"] = false,
		},
	},
}
