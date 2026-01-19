-- NOTE: Global Variables

-- Colorscheme
-- Available themes: "tokyonight" and "nvchad"
-- github_dark_dimmed is a custom NvChad theme with extensive language highlighting
vim.g.colorscheme = "nvchad"

local sysname = vim.uv.os_uname().sysname
local os = sysname:match("Windows") and "Windows" or sysname:match("Linux") and "Linux" or sysname -- fallback to whatever system name was returned

-- Boolean convenience flag for platform checks
local is_windows = os == "Windows"

-- --------------------------------------------------------------------
-- Provider settings
-- --------------------------------------------------------------------

-- Disable language providers you don’t use to speed up startup time
-- These providers allow Neovim to run external languages inside the editor.
-- Setting them to 0 means they will not be loaded.
vim.g.loaded_node_provider = 0 -- Disable Node.js provider
vim.g.loaded_python3_provider = 0 -- Disable Python 3 provider
vim.g.loaded_perl_provider = 0 -- Disable Perl provider
vim.g.loaded_ruby_provider = 0 -- Disable Ruby provider

vim.g.os = os
vim.g.is_windows = is_windows

vim.g.mkdp_auto_close = false -- Don't Exit Preview When Switching Buffers
vim.g.startup_message = false -- Show startup message
vim.g.random_header = false -- Show random header
vim.g.skip_ts_context_commentstring_module = true -- disable treesitter context commentstring
vim.g.toggle_cmp = true -- enable nvim-cmp
vim.g.toggle_theme_icon = "   "
vim.g.border_enabled = false -- NOTE: Toggle border for LSP Windows, nvim-cmp, lazy, which-key, mason
vim.g.mapleader = " "
vim.g.maplocalleader = "  "
vim.g.disable_autoformat = true
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal

vim.g.path_delimiter = is_windows and ";" or ":" -- Used for PATH-like variables
vim.g.path_separator = is_windows and "\\" or "/" -- Used for filesystem paths

-- Environment-specific settings
require("config.env")
