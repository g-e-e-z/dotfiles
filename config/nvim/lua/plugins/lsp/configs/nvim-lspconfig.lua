-- NOTE: Main LSP Configuration
-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`
-- Use vim.fn.stdpath("config") to get the base Neovim configuration directory.
-- local function get_lsp_server_names()
-- 	local config_path = vim.fn.stdpath("config")
-- 	local settings_path = config_path .. "/lua/plugins/lsp/settings"
--
-- 	local server_names = {}
-- 	local files = vim.fn.globpath(settings_path, "*.lua", false, true)
--
-- 	for _, file in ipairs(files) do
-- 		local filename = vim.fn.fnamemodify(file, ":t")
-- 		local server_name = filename:match("^(.*)%.lua$")
-- 		if server_name then
-- 			table.insert(server_names, server_name)
-- 		end
-- 	end
-- 	-- Log the result for debugging
-- 	-- vim.notify("LSP Servers: " .. vim.inspect(server_names), vim.log.levels.INFO)
-- 	return server_names
-- end
--
-- return {
-- 	"neovim/nvim-lspconfig",
-- 	dependencies = {
-- 		-- Automatically install LSPs and related tools to stdpath for Neovim
-- 		-- Mason must be loaded before its dependents so we need to set it up here.
-- 		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
-- 		{ "williamboman/mason.nvim", opts = {} },
-- 		"williamboman/mason-lspconfig.nvim",
--
-- 		-- Useful status updates for LSP.
-- 		{ "j-hui/fidget.nvim", opts = {} },
--
-- 		-- Allows extra capabilities provided by nvim-cmp
-- 		"hrsh7th/cmp-nvim-lsp",
-- 	},
-- 	config = function()
-- 		local config = {
-- 			-- virtual_text = { current_line = true },
-- 			virtual_text = true,
-- 			update_in_insert = false,
-- 			underline = true,
-- 			severity_sort = true,
-- 			float = {
-- 				focusable = false,
-- 				style = "minimal",
-- 				border = "rounded",
-- 				source = "always",
-- 				header = "",
-- 				prefix = "",
-- 			},
-- 		}
-- 		-- TODO: Pull out mason into its own lua file
-- 		vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason | Installer", silent = true })
--
-- 		local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
--
-- 		if vim.version().minor >= 11 then
-- 			config.signs = {
-- 				text = {
-- 					[vim.diagnostic.severity.ERROR] = signs.Error,
-- 					[vim.diagnostic.severity.WARN] = signs.Warn,
-- 					[vim.diagnostic.severity.HINT] = signs.Hint,
-- 					[vim.diagnostic.severity.INFO] = signs.Info,
-- 				},
-- 				linehl = {
-- 					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
-- 					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
-- 					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
-- 					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
-- 				},
-- 				numhl = {
-- 					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
-- 					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
-- 					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
-- 					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
-- 				},
-- 			}
-- 		else
-- 			for type, icon in pairs(signs) do
-- 				local hl = "DiagnosticSign" .. type
-- 				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- 			end
-- 			config.signs = { active = signs }
-- 		end
--
-- 		vim.diagnostic.config(config)
--
-- 		local mason_lspconfig = require("mason-lspconfig")
-- 		local on_attach = require("plugins.lsp.opts").on_attach
-- 		local on_init = require("plugins.lsp.opts").on_init
-- 		local capabilities = require("plugins.lsp.opts").capabilities
-- 		capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- 		-- The setup_handlers function below will not install the needed servers
-- 		-- this helper function will ensure they are installed, could delete for
-- 		-- performance as manually installing the servers needed is a valid solution
-- 		require("mason-lspconfig").setup({
-- 			automatic_installation = true,
-- 			ensure_installed = get_lsp_server_names(),
-- 		})
--
-- 		mason_lspconfig.setup_handlers({
-- 			-- Automatically configure the LSP installed
-- 			function(server_name)
-- 				local opts = {
-- 					on_attach = on_attach,
-- 					on_init = on_init,
-- 					capabilities = capabilities,
-- 				}
--
-- 				local require_ok, server = pcall(require, "plugins.lsp.settings." .. server_name)
-- 				if require_ok then
-- 					opts = vim.tbl_deep_extend("force", opts, server)
-- 				end
--
-- 				-- Neovim < 0.11
-- 				-- require("lspconfig")[server_name].setup(opts)
-- 				-- Neovim >= 0.11
-- 				vim.lsp.config(server_name, opts)
-- 				vim.lsp.enable(server_name)
-- 			end,
-- 		})
-- 	end,
-- }

--  NOTE: LSP Configuration
return {
  "neovim/nvim-lspconfig",
  init = function()
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
  cmd = "LspInfo",
  config = function()
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

    if vim.version().minor >= 11 then
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
    else
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      config.signs = { active = signs }
    end

    vim.diagnostic.config(config)

    if vim.g.border_enabled then
      -- NOTE: Enable border for LSP UI Windows (lspinfo)
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- NOTE: Enable border for LSP hover, signature help. But cannot use along with Noice's hover, signature help!

      --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --     border = "rounded",
      --   })
      --   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --     border = "rounded",
      --   })
    end
  end,
}
