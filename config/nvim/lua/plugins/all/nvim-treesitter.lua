-- NOTE: Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = "maintained",
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
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
