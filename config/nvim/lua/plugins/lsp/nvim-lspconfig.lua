---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  lazy = false,

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
        servers[server] =
          vim.tbl_deep_extend("force", servers[server] or {}, custom)
      else
        servers[server] = servers[server] or {}
      end
    end

    -- Discover server config files
    local settings_dir =
      vim.fn.stdpath("config") .. "/lua/" .. custom_path:gsub("%.", "/")
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
  end,
}

