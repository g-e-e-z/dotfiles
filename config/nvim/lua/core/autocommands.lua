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

-- TODO: Redundancy somewhere here
autocmd("FileType", {
	pattern = { "c", "cpp", "py", "java", "cs" },
	callback = function()
		vim.bo.shiftwidth = 4
	end,
	group = general,
	desc = "Set shiftwidth to 4 in these filetypes",
})
autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		-- Define Prettier formatting function for Markdown
		vim.api.nvim_create_user_command("Prettier", function()
			vim.cmd("!prettier --write %")
			vim.cmd("edit")
		end, {})
		vim.api.nvim_set_keymap("n", "<leader>lf", ":Prettier<CR>", { noremap = true, silent = true })
	end,
	group = general,
	desc = "Set shiftwidth to 2 in these filetypes",
})

autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "log" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	group = general,
	desc = "Enable Wrap in these filetypes",
})

local overseer = augroup("Overseer", { clear = true })

autocmd("FileType", {
  pattern = "OverseerList",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
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
