-- NOTE: Keymaps
--  See `:help vim.keymap.set()`
local cwd = vim.fn.stdpath "config" .. "/"
local config_dir = { cwd }
local utils = require "config.utils"

--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- overwritten by quit
vim.keymap.set("n", "df", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "dj", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--
-- remap
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

-- Delete Without Yank
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i","<C-c>", "<Esc>")

vim.keymap.set("n","Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n","<leader>x", "<cmd>!chmod +x %<CR>", { desc = "General | Executable", silent = true })

-- Remove All Text
vim.keymap.set("n", "<leader>R", "<cmd>%d+<cr>", { desc = "General | Remove All Text", silent = true })

-- Yank To Clipboard
vim.keymap.set({"n","v"}, "<leader>y", "\"+y", { desc = "General | Yank To Clipboard", silent = true })

-- Write
vim.keymap.set("n", "<leader>w", function()
  vim.cmd("wa!")
  vim.notify("Buffer Writen", vim.log.levels.INFO, { title = "Info" })
end, { desc = "General | Write", silent = true })

-- Quit
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "General | Quit All", silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>", { desc = "General | Quit", silent = true })

-- Close Buffer
vim.keymap.set("n", "<leader>c", "<cmd>Bdelete!<cr>", { desc = "General | Close Buffer", silent = true })

-- Better Down/ Up
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "General | Better Down", expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "General | Better Up", expr = true, silent = true })

-- Better Down/ Up  (Visual Mode)
vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "General | Better Down", expr = true, silent = true })
vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "General | Better Up", expr = true, silent = true })

-- -- Go to upper window
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "General | Go to upper window", silent = true })
--
-- -- Go to lower window
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "General | Go to lower window", silent = true })
--
-- -- Go to left window
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "General | Go to left window", silent = true })
--
-- -- Go to right window
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "General | Go to right window", silent = true })

-- -- Close window
-- vim.keymap.set("n", "<leader>w", function()
--   if vim.bo.buftype == "terminal" then
--     vim.cmd "Bdelete!"
--     vim.cmd "silent! close"
--   elseif #vim.api.nvim_list_wins() > 1 then
--     vim.cmd "silent! close"
--   else
--     vim.notify("Can't Close Window", vim.log.levels.WARN, { title = "Close Window" })
--   end
-- end, { desc = "General | Close window", silent = true })

-- Add size at the top

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "General | Add size at the top", silent = true })
-- Add size at the bottom
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "General | Add size at the bottom", silent = true })

-- Add size at the left
vim.keymap.set(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<CR>",
  { desc = "General | Add size at the left", silent = true }
)

-- Add size at the right
vim.keymap.set(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<CR>",
  { desc = "General | Add size at the right", silent = true }
)

-- Indent backward
vim.keymap.set("n", "<", "<<", { desc = "General | Indent backward", silent = true })

-- Indent forward
vim.keymap.set("n", ">", ">>", { desc = "General | Indent forward", silent = true })

-- Indent backward (Visual Mode)
vim.keymap.set("v", "<", "<gv", { desc = "General | Indent backward", silent = true })

-- Indent forward (Visual Mode)
vim.keymap.set("v", ">", ">gv", { desc = "General | Indent forward", silent = true })

-- Move the line up
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "General | Move the line up", silent = true })

-- Move the line down
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "General | Move the line down", silent = true })

-- Toggle Theme Mode
vim.keymap.set("n", "<leader>Ot", function()
    if vim.opt.background:get() == "dark" then
		vim.opt.background = "light"
        vim.notify("Background set to light", vim.log.levels.INFO, { title = "Light Mode" })
	else
		vim.opt.background = "dark"
        vim.notify("Background set to dark", vim.log.levels.INFO, { title = "Dark Mode" })
	end
end, { desc = "Options | Toggle Theme Mode", silent = true })

-- Toggle Wrap
vim.keymap.set("n", "<leader>Ow", function()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Line Wrap" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Line Wrap" })
  end
end, { desc = "Options | Toggle Wrap", silent = true })

vim.keymap.set("n", "<leader>Os", function()
  vim.wo.spell = not vim.wo.spell
  if vim.wo.spell then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Spell Check" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Spell Check" })
  end
end, { desc = "Options | Toggle Spell Check", silent = true })

-- Find Config Files
vim.keymap.set("n", "<leader>nf", function()
  require("telescope.builtin").find_files {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Find Files", silent = true })

-- Grep Config Files
vim.keymap.set("n", "<leader>ng", function()
  require("telescope.builtin").live_grep {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end, { desc = "Neovim | Grep Config Files", silent = true })

-- TODO: Toggle Cheatsheet
-- vim.keymap.set("n", "<leader>nc", "<cmd>NvCheatsheet<cr>", { desc = "Neovim | Toggle Cheatsheet", silent = true })

-- Inspect
vim.keymap.set("n", "<leader>ni", function()
  if vim.version().minor >= 9 then
    vim.cmd "Inspect"
  else
    vim.notify("Inspect isn't available in this neovim version", vim.log.levels.WARN, { title = "Inspect" })
  end
end, { desc = "Neovim | Inspect", silent = true }) -- only available on neovim >= 0.9

-- Messages
vim.keymap.set("n", "<leader>nm", "<cmd>messages<cr>", { desc = "Neovim | Messages", silent = true })

-- Health
vim.keymap.set("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "Neovim | Health", silent = true })

-- Version
vim.keymap.set("n", "<leader>nv", function()
  local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
end, { desc = "Neovim | Version", silent = true })

-- Run Code
vim.keymap.set("n", "<leader>dr", function()
  utils.run_code()
end, { desc = "Debug | Run Code", silent = true })

-- Clean
vim.keymap.set("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Lazy | Clean", silent = true })

-- Check
vim.keymap.set("n", "<leader>pC", "<cmd>Lazy check<cr>", { desc = "Lazy | Check", silent = true })

-- Debug
vim.keymap.set("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Lazy | Debug", silent = true })

-- Install
vim.keymap.set("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Lazy | Install", silent = true })

-- Sync
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Lazy | Sync", silent = true })

-- Log
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Lazy | Log", silent = true })

-- Home
vim.keymap.set("n", "<leader>ph", "<cmd>Lazy home<cr>", { desc = "Lazy | Home", silent = true })

-- Help
vim.keymap.set("n", "<leader>pH", "<cmd>Lazy help<cr>", { desc = "Lazy | Help", silent = true })

-- Profile
vim.keymap.set("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Lazy | Profile", silent = true })

-- Update
vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Lazy | Update", silent = true })

