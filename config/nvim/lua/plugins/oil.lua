return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
    },
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    float = {
        -- Padding around the floating window
        padding = 5,
        -- max_width = 0,
        -- max_height = 0,
        border = "rounded",
        win_options = {
            winblend = 0,
        },
    },
    view_options = {
        show_hidden = true,
        natural_order = true,
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
