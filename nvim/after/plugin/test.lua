require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-go"),
  },
})

local run = require("neotest").run

vim.keymap.set("n", "<leader>t", function() run.run() end)
vim.keymap.set("n", "<leader>T", function() run.run(vim.fn.expand("%")) end)
