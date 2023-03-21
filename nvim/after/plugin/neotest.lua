require("neotest").setup({
  adapters = {
    require("neotest-go"),
  },
})

require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
})
