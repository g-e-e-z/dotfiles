-- NOTE: Debugging
return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{ "nvim-neotest/nvim-nio" },
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		{ "mfussenegger/nvim-dap" },
	},
	init = function()
		local dap = require("dap")

		vim.keymap.set(
			"n",
			"<leader>dc",
			dap.continue,
			{ desc = "DAP | Continue", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>do",
			dap.step_over,
			{ desc = "DAP | Step Over", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>di",
            dap.step_into,
			{ desc = "DAP | Step Into", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>du",
            dap.step_out,
			{ desc = "DAP | Step Out", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>db",
            dap.toggle_breakpoint,
			{ desc = "DAP | Breakpoint", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>dB",
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
			{ desc = "DAP | Breakpoint Condition", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>dd",
			"<cmd>lua require'dapui'.toggle()<cr>",
			{ desc = "DAP | Dap UI", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>dl",
			"<cmd>lua require'dap'.run_last()<cr>",
			{ desc = "DAP | Run Last", silent = true }
		)
	end,
	opts = {
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
	},
}
