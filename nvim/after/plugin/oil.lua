require("oil").setup({
    keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
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
    }
})
