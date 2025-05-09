-- NOTE: Autocompletion

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	init = function()
		vim.keymap.set("n", "<leader>Oa", function()
			vim.g.toggle_cmp = not vim.g.toggle_cmp
			if vim.g.toggle_cmp then
				vim.notify("Toggled On", vim.log.levels.INFO, { title = "Autocomplete" })
			else
				vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Autocomplete" })
			end
		end, { desc = "Options | Toggle Autocomplete" })
	end,

	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		luasnip.filetype_extend("javascriptreact", { "html" })
		luasnip.filetype_extend("typescriptreact", { "html" })
		luasnip.filetype_extend("javascript", { "javascriptreact" })
		luasnip.filetype_extend("typescript", { "typescriptreact" })

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(), -- Select the [n]ext item
				["<C-p>"] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack / [f]orward
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.confirm({ select = true }), -- Accept ([e]nter) the completion.

				-- ["<C-Space>"] = cmp.mapping.complete({}), -- Manually trigger a completion from nvim-cmp.

				["<C-Space>"] = cmp.mapping(
					function() -- <c-l> will move you to the right of each of the expansion locations.
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end,
					{ "i", "s" }
				),
				["<C-h>"] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),
			sources = {
				{
					name = "lazydev",
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
		if vim.g.border_enabled then
			vim.opts.window = {
				completion = require("cmp").config.window.bordered(),
				documentation = require("cmp").config.window.bordered(),
			}
		end
	end,
	dependencies = {
		-- For Rust
		{
			"saecki/crates.nvim",
			tag = "v0.4.0",
			opts = {},
		},
		-- Commandline completions
		{
			"hrsh7th/cmp-cmdline",
			config = function()
				local cmdline_mappings = vim.tbl_extend("force", {}, require("cmp").mapping.preset.cmdline(), {
					["<C-e>"] = { c = require("cmp").mapping.confirm { select = true } },
				})

				require("cmp").setup.cmdline(":", {
					mapping = cmdline_mappings,
					sources = {
						{ name = "cmdline" },
					},
				})
			end,
		},

		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				{
				  'rafamadriz/friendly-snippets',
				  config = function()
				    require('luasnip.loaders.from_vscode').lazy_load()
				  end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
}
