-- NOTE: For managing error and warning messages
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  init = function()
    vim.keymap.set(
      "n",
      "<leader>db",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      { desc = "Trouble | Buffer Diagnostics", silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>dw",
      "<cmd>Trouble diagnostics toggle<cr>",
      { desc = "Trouble | Workspace Diagnostics", silent = true }
    )
  end,
  opts = {
    focus = true, -- Focus the window when opened
  },
}

