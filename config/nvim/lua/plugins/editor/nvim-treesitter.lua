-- NOTE: Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			require("nvim-treesitter.config").setup({
				ensure_installed = "maintained",
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		init = function()
			vim.keymap.set(
				"n",
				"<leader>Oc",
				"<cmd>TSContextToggle<cr>",
				{ desc = "Treesitter | Toggle Context", silent = true }
			)
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { desc = "Treesitter | Jumping to context (upwards)", silent = true })
		end,
		opts = {
			enable = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					enable = true,
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
					},
					include_surrounding_whitespace = false,
				},
			})

			-- Keymaps (this is the correct place)
			local select = require("nvim-treesitter-textobjects.select")

			vim.keymap.set({ "x", "o" }, "am", function()
				select.select_textobject("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "im", function()
				select.select_textobject("@function.inner", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@local.scope", "locals")
			end)
		end,
	},
}
