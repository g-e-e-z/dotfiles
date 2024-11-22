require('luasnip').filetype_extend("javascriptreact", { "javascript" })
require("luasnip").filetype_extend("typescript", { "javascript" })

require('luasnip').filetype_extend("typescriptreact", { "javascript" })
require('luasnip').filetype_extend("typescriptreact", { "typescript" })
require('luasnip').filetype_extend("javascript", { "html" })
require("luasnip/loaders/from_vscode").lazy_load()
