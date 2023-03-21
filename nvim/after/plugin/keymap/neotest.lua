local Remap = require("geezee.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>tt", function()
    require("neotest").run.run()
end)

nnoremap("<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
end)
