-- NOTE: Autocommands
--  See `:help lua-guide-autocommands`

local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

-- autocmd("VimEnter", {
--   callback = function(data)
--     -- buffer is a directory
--     local directory = vim.fn.isdirectory(data.file) == 1
--
--     -- change to the directory
--     if directory then
--       vim.cmd.cd(data.file)
--       vim.cmd "Telescope find_files"
--       -- require("nvim-tree.api").tree.open()
--     end
--   end,
--   group = general,
--   desc = "Open Telescope when it's a Directory",
-- })

-- Remove Trailing Whitespaces
autocmd("BufWritePre", {
	group = general,
	pattern = "*",
	desc = "Remove trailing white space on save",
	command = "%s/\\s\\+$//e",
})

-- Enable Line Number in Telescope Preview
autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.number = true
	end,
	group = general,
	desc = "Enable Line Number in Telescope Preview",
})

autocmd("BufReadPost", {
	callback = function()
		if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
	group = general,
	desc = "Go To The Last Cursor Position",
})

autocmd("TextYankPost", {
	callback = function()
		if vim.version().minor >= 11 then
			require("vim.hl").on_yank({ higroup = "Visual", timeout = 200 })
		else
			require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
		end
	end,
	group = general,
	desc = "Highlight when yanking",
})

local ft_augroup = vim.api.nvim_create_augroup("FiletypeLocalSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = ft_augroup,
	callback = function(event)
		local ft = event.match

		-- Default local indentation (inherits global: 4 spaces)
		vim.opt_local.expandtab = true

		-- 2-space indentation languages
		if
			vim.tbl_contains({
				"css",
				"html",
				"javascript",
				"typescript",
				"lua",
				"yaml",
				"markdown",
			}, ft)
		then
			vim.opt_local.tabstop = 2
			vim.opt_local.shiftwidth = 2
			vim.opt_local.softtabstop = 2
		end

		-- Explicit 4-space languages (clarity > necessity)
		if vim.tbl_contains({
			"c",
			"cpp",
			"python",
			"java",
			"cs",
		}, ft) then
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.softtabstop = 4
		end

		-- Wrapped + spellchecked text-like buffers
		if vim.tbl_contains({
			"gitcommit",
			"markdown",
			"text",
			"log",
		}, ft) then
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end

		-- Markdown-specific tooling
		if ft == "markdown" then
			vim.api.nvim_buf_create_user_command(0, "Prettier", function()
				vim.cmd("!prettier --write %")
				vim.cmd("edit")
			end, { desc = "Format markdown with Prettier" })

			vim.keymap.set(
				"n",
				"<leader>lf",
				"<cmd>Prettier<cr>",
				{ buffer = true, silent = true, desc = "Format Markdown" }
			)
		end
	end,
})

local overseer = augroup("Overseer", { clear = true })

autocmd("FileType", {
	pattern = "OverseerList",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert!")
	end,
	group = overseer,
	desc = "Enter Normal Mode In OverseerList",
})

autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("plugins.lsp.opts").on_attach(client, bufnr)
	end,
})
