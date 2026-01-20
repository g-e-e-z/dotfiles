return {
	"neovim/nvim-lspconfig",
	lazy = false,
	opts = function()
		vim.keymap.set("n", "<leader>lf", "<cmd>Format<cr>", { desc = "LSP | Format", silent = true })
		vim.keymap.set("n", "<leader>lF", "<cmd>FormatToggle<cr>", { desc = "LSP | Toggle Autoformat", silent = true })
		vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP | Info", silent = true })
		vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<cr>", { desc = "LSP | Restart", silent = true })

		vim.keymap.set("n", "<leader>lh", function()
			if vim.version().minor >= 10 then
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end
		end, { desc = "LSP | Toggle Inlay Hints", silent = true })
	end,

	config = function()
		local servers = {}
		local custom_path = "plugins.lsp.settings"

		local disabled_servers = {
			"phpactor",
			"rust_analyzer",
		}

		local function is_disabled(server)
			return vim.tbl_contains(disabled_servers, server)
		end

		local function extend_server(server)
			if is_disabled(server) then
				return
			end

			local ok, custom = pcall(require, custom_path .. "." .. server)
			if ok and type(custom) == "table" then
				servers[server] = vim.tbl_deep_extend("force", servers[server] or {}, custom)
			else
				servers[server] = servers[server] or {}
			end
		end

		-- Discover server config files
		local settings_dir = vim.fn.stdpath("config") .. "/lua/" .. custom_path:gsub("%.", "/")
		local files = vim.fn.glob(settings_dir .. "/*.lua", false, true)

		for _, file in ipairs(files) do
			local server = vim.fn.fnamemodify(file, ":t:r")
			extend_server(server)
		end

		-- Register configs
		for server, config in pairs(servers) do
			vim.lsp.config(server, config)
		end

		-- Enable servers
		vim.lsp.enable(vim.tbl_keys(servers))

		--- Symbols
		local config = {
			-- Enable virtual text
			virtual_text = false,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		}

		local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }

		config.signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.HINT] = signs.Hint,
				[vim.diagnostic.severity.INFO] = signs.Info,
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			},
		}
		vim.diagnostic.config(config)
	end,
}
