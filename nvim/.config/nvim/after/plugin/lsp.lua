local Remap = require("geezee.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

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

    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<c-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        { "i", "c" }
      ),
      ["<c-space>"] = cmp.mapping {
        i = cmp.mapping.complete(),
        c = function(
          _ --[[fallback]]
        )
          if cmp.visible() then
            if not cmp.confirm { select = true } then
              return
            end
          else
            cmp.complete()
          end
        end,
      },
    },
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
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 2},
        {name = 'luasnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 2},
    })
})

local function config()
	return {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gD", function() vim.lsp.buf.declaration() end)
			nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("gt", function() vim.lsp.buf.type_definition() end)
			nnoremap("gi", function() vim.lsp.buf.implementation() end)
			nnoremap("K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
			nnoremap("<leader>f", function() vim.lsp.buf.formatting() end)
            -- Future me, read this -> :h vim.diagnostics
			nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("df", function() vim.diagnostic.goto_next() end)
			nnoremap("dp", function() vim.diagnostic.goto_prev() end)
            -- Verify what this does
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}
end

require("lspconfig").jedi_language_server.setup(config())

