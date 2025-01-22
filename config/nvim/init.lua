require "core.globals"
require "core.env"

if vim.version().minor >= 11 then
  vim.tbl_add_reverse_lookup = function(tbl)
    for k, v in pairs(tbl) do
      tbl[v] = k
    end
  end
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.runtimepath:prepend(lazypath)

-- NOTE: Load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

require "options"
require "core.commands"
require "core.autocommands"
-- require "core.filetypes"
require "core.utils"
require "mappings"
