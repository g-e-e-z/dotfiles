-- NOTE: Package installer

local function get_configs()
  local config_path = vim.fn.stdpath("config")
  local settings_path = config_path .. "/lua/plugins/lsp/settings"
  local files = vim.fn.globpath(settings_path, "*.lua", false, true)

  local servers = {}

  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t:r") -- get filename without extension
    local ok, config = pcall(dofile, file)
    if ok then
      servers[filename] = config
    else
      vim.notify("Error loading LSP config for " .. filename .. ": " .. config, vim.log.levels.ERROR)
    end
  end

  return servers
end

return {
  "mason-org/mason.nvim",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  init = function()
    vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason | Installer", silent = true })
  end,
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonInstallAll",
    "MasonUpdate",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      local mason = require("mason")
      -- local path = require "mason-core.path"
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          border = vim.g.border_enabled and "rounded" or "none",
          -- Whether to automatically check for new versions when opening the :Mason window.
          check_outdated_packages_on_open = true,
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        -- install_root_dir = path.concat { vim.fn.stdpath "config", "/lua/custom/mason" },
      })

      local servers = get_configs()
      local server_names = vim.tbl_keys(servers)

      mason_lspconfig.setup({
                automatic_enable = true,
                ensure_installed = server_names
            })

      for server, settings in pairs(servers) do
        vim.lsp.config(server, settings)
        -- vim.lsp.enable(server)
      end

    end,
  },
  opts = {
    registries = {
      "github:mason-org/mason-registry",
    },
  },
}

