local Remap = require("geezee.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap


local capabilities = vim.lsp.protocol.make_client_capabilities()


-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	-- cmp_tabnine = "[TN]",
	path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			-- if entry.source.name == "cmp_tabnine" then
			-- 	if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
			-- 		menu = entry.completion_item.data.detail .. " " .. menu
			-- 	end
			-- 	vim_item.kind = ""
			-- end
			vim_item.menu = menu
			return vim_item
		end,
	},
    -- TODO: Look into cmp_tabnine completion
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer' },
    })
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("gt", function() vim.lsp.buf.type_definition() end)
			nnoremap("gi", function() vim.lsp.buf.implementation() end)
			nnoremap("K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
            -- Future me, read this -> :h vim.diagnostics
			nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("df", function() vim.diagnostic.goto_next() end)
			nnoremap("dp", function() vim.diagnostic.goto_prev() end)
            -- Verify what this does
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

require("lspconfig").pyright.setup{config()}


