-- NOTE: Fuzzy Finder (files, lsp, etc)
-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
    -- version = false,
	-- branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },

		-- Extension for switching colroschemes with preview
		-- "andrew-george/telescope-themes",
	},
	config = function()
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			defaults = {
				layout_strategy = "flex",
				sorting_strategy = "ascending",
				-- layout_config = { prompt_position = "top" },
				file_ignore_patterns = {
					"^%.git/", "%.png"
				},
				path_display = { truncate = 3 },
			},
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- pcall(require("telescope").load_extension, "themes")

		--
		vim.keymap.set(
			"n",
			"<leader>fa",
			"<cmd>Telescope autocommands<cr>",
			{ desc = "Telescope | Autocommands", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope git_commits<cr>",
			{ desc = "Telescope | Commits", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			{ desc = "Telescope | Files", silent = true }
		)
		-- vim.keymap.set(
		--     "n",
		--     "<leader>fF",
		--     'lua require("telescope.builtin").find_files({ hidden = true })',
		--     { desc = "Telescope | Files (Hidden)", silent = true }
		-- )
		-- vim.keymap.set("n", "<leader>fs", "<cmd>Telescope persisted<cr>", { desc = "Telescope | Sessions", silent = true })
		vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Telescope | Marks", silent = true })
		vim.keymap.set(
			"n",
			"<leader>fM",
			"<cmd>Telescope man_pages<cr>",
			{ desc = "Telescope | Man Pages", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>fw",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Telescope | Word", silent = true }
		)
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope | Grep", silent = true })
		vim.keymap.set(
			"n",
			"<leader>ft",
			"<cmd>Telescope colorscheme<cr>",
			{ desc = "Telescope | Themes", silent = true }
		)
		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope | Buffers", silent = true })
		vim.keymap.set(
			"n",
			"<leader>fn",
			"<cmd>lua require('telescope').extensions.notify.notify()<cr>",
			{ desc = "Telescope | Notify History", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>fp",
			"<cmd>Telescope projects<cr>",
			{ desc = "Telescope | Projects", silent = true }
		)
		vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope | Help", silent = true })
		vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope | Keymaps", silent = true })
		vim.keymap.set(
			"n",
			"<leader>fC",
			"<cmd>Telescope commands<cr>",
			{ desc = "Telescope | Commands", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>fr",
			"<cmd>Telescope lsp_references<cr>",
			{ desc = "Telescope | References", silent = true }
		)

		vim.keymap.set(
			"n",
			"<leader>fR",
			"<cmd>Telescope oldfiles<cr>",
			{ desc = "Telescope | Recent Files", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>fH",
			"<cmd>Telescope highlights<cr>",
			{ desc = "Telescope | Highlights", silent = true }
		)
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>ls",
		-- 	"<cmd>Telescope lsp_document_symbols<cr>",
		-- 	{ desc = "Telescope | Buffer Symbols", silent = true }
		-- )
		vim.keymap.set(
			"n",
			"<leader>lS",
			"<cmd>Telescope lsp_workspace_symbols<cr>",
			{ desc = "Telescope | Workspace Symbols", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>gb",
			"<cmd>Telescope git_branches<cr>",
			{ desc = "Telescope | Checkout branch", silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>gc",
			"<cmd>Telescope git_commits<cr>",
			{ desc = "Telescope | Checkout commit", silent = true }
		)

		-- See `:help telescope.builtin`
		-- local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		-- vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		-- vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[F]ind [T]elescope" })
		-- vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		-- vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[F]ind [S]tring" })
		-- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[F]ind [R]esume" })
		-- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
		-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		-- vim.keymap.set("n", "<leader>/", function()
		-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		-- vim.keymap.set("n", "<leader>s/", function()
		-- 	builtin.live_grep({
		-- 		grep_open_files = true,
		-- 		prompt_title = "Live Grep in Open Files",
		-- 	})
		-- end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		-- vim.keymap.set("n", "<leader>sn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- end, { desc = "[S]earch [N]eovim files" })
	end,
}
