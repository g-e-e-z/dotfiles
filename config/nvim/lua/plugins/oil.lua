---@type NvPluginSpec
-- NOTE: File explorer like vim-vinegar
return {
  "stevearc/oil.nvim",
  -- init = function()
  --   vim.keymap.set("n", "<leader>O", function()
  --     if vim.bo.filetype == "oil" then
  --       vim.cmd "Bdelete!"
  --     else
  --       vim.cmd "Oil"
  --     end
  --   end, { desc = "Oil | Toggle Oil" })
  -- end,
  cmd = "Oil",
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
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        -- is_hidden_file = function(name, bufnr)
        --     return vim.startswith(name, ".")
        -- end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        -- is_always_hidden = function(name, bufnr)
        --     return false
        -- end,
        -- Sort file names in a more intuitive order for humans. Is less performant,
        -- so you may want to set to false if you work with large directories.
        natural_order = true,
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
        },
    },
  },
}



