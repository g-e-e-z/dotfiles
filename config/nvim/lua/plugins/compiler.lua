-- NOTE: Code Runner
return {
	"Zeioth/compiler.nvim",
	init = function()
		vim.keymap.set(
			"n",
			"<leader>rr",
			"<cmd>CompilerRedo<cr>",
			{ desc = "Compiler | Redo Last Action", silent = true }
		)

		vim.keymap.set("n", "<leader>ro", "<cmd>CompilerOpen<cr>", { desc = "Compiler | Open", silent = true })

		vim.keymap.set(
			"n",
			"<leader>rs",
			"<cmd>CompilerStop<cr>",
			{ desc = "Compiler | Stop All Tasks", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>rt",
			"<cmd>CompilerToggleResults<cr>",
			{ desc = "Compiler | Toggle Results", silent = true }
		)
	end,
	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	dependencies = {
		{ -- The task runner we use
			"stevearc/overseer.nvim",
			commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
			cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
			opts = {
				task_list = {
					direction = "bottom",
					min_height = 25,
					max_height = 25,
					default_detail = 1,
				},
			},
		},
	},
	opts = {},
}
