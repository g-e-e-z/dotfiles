local M = {}
local keymap = vim.keymap.set
local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.lsp_keymaps = function(bufnr)
	keymap("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = bufnr, desc = "Go To Definition" , silent = true })
	keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go To Declaration" , silent = true })
	-- keymap("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr, silent = true })
	keymap("n", "gI", require("telescope.builtin").lsp_implementations, { buffer = bufnr, silent = true }) -- Never used this
	keymap("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, { buffer = bufnr, desc = "Go To Type Definitions", silent = true })
	keymap("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { buffer = bufnr, desc = "Document Symbols" , silent = true })
	keymap(
		"n",
		"<leader>Ds",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = "Dynamic Workspace Symbols", silent = true }
	)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP | Rename", silent = true })
	keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, silent = true })
	keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP | Code Action", silent = true })

	keymap("n", "<leader>lf", "<cmd>Format<cr>", { desc = "LSP | Format", silent = true })
	keymap("n", "<leader>lF", "<cmd>FormatToggle<cr>", { desc = "LSP | Toggle Autoformat", silent = true })
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP | Info", silent = true })
	keymap("n", "<leader>lR", "<cmd>LspRestart<cr>", { desc = "LSP | Restart", silent = true })

	keymap("n", "<leader>lh", function()
		if vim.version().minor >= 10 then
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			if vim.lsp.inlay_hint.is_enabled() then
				vim.notify("Inlay hints enabled.", vim.log.levels.INFO, { title = "Hints" })
			else
				vim.notify("Inlay hints disabled.", vim.log.levels.INFO, { title = "Hints" })
			end
		end
	end, { desc = "LSP | Toggle Inlay Hints", silent = true })
end

-- See `:help CursorHold` for information about when this is executed
-- Highlight symbol under cursor
M.lsp_highlight = function(client, bufnr)
	if client.supports_method("textDocument/documentHighlight") then
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

M.on_attach = function(_, bufnr)
	M.lsp_keymaps(bufnr)
end

M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

return M
