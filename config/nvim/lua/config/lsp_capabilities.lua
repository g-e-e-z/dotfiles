local M = {}
local keymap = vim.keymap.set
local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.lsp_keymaps = function(bufnr)
    keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go To Definition", silent = true })
    keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go To Declaration", silent = true })
    keymap("n", "gR", require("telescope.builtin").lsp_references, { buffer = bufnr, silent = true })
    keymap("n", "gI", require("telescope.builtin").lsp_implementations, { buffer = bufnr, silent = true }) -- Never used this
    keymap(
        "n",
        "<leader>D",
        require("telescope.builtin").lsp_type_definitions,
        { buffer = bufnr, desc = "Go To Type Definitions", silent = true }
    )
    keymap(
        "n",
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        { buffer = bufnr, desc = "Document Symbols", silent = true }
    )
    keymap(
        "n",
        "<leader>Ds",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        { buffer = bufnr, desc = "Dynamic Workspace Symbols", silent = true }
    )
    keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP | Rename", silent = true })
    keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, silent = true })
    keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP | Code Action", silent = true })

    keymap("n", "<leader>lh", function()
        if vim.version().minor >= 10 then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            if vim.lsp.inlay_hint.is_enabled() then
                vim.notify("Inlay hints enabled.", vim.log.levels.INFO, { title = "Hints" })
            else
                vim.notify("Inlay hints disabled.", vim.log.levels.INFO, { title = "Hints" })
            end
        end
    end, { desc = "LSP | Toggle Inlay Hints", silent = true })

    ------ TODO: Find how to make this only apply to clangd
    keymap("n", "<leader>ls", function()
        local fname = vim.fn.expand("%:t:r") -- filename without extension
        local ext = vim.fn.expand("%:e") -- current extension
        local dir = vim.fn.expand("%:p:h")
        local targets = {}

        if ext == "cpp" or ext == "cc" or ext == "cxx" then
            targets = {
                dir .. "/" .. fname .. ".h",
                dir .. "/" .. fname .. ".hpp",
                "include/**/" .. fname .. ".h",
                "include/**/" .. fname .. ".hpp",
                "inc/**/" .. fname .. ".h",
            }
        elseif ext == "h" or ext == "hpp" then
            targets = {
                dir .. "/" .. fname .. ".cpp",
                dir .. "/" .. fname .. ".cc",
                dir .. "/" .. fname .. ".cxx",
                "src/**/" .. fname .. ".cpp",
                "lib/**/" .. fname .. ".cpp",
            }
        else
            print("Unsupported file type: " .. ext)
            return
        end

        for _, pattern in ipairs(targets) do
            local matches = vim.fn.glob(pattern, true, true)
            if #matches > 0 then
                vim.cmd("edit " .. matches[1])
                return
            end
        end

        print("No matching file found for: " .. fname)
    end, { desc = "LSP CPP Smart switch .cpp/.h" })
end

-- See `:help CursorHold` for information about when this is executed
-- Highlight symbol under cursor
M.lsp_highlight = function(client, bufnr)
    if client:supports_method "textDocument/documentHighlight" then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
        })
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = "lsp_document_highlight",
        }
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end
M.on_attach = function(client, bufnr)
    M.lsp_keymaps(bufnr)
    M.lsp_highlight(client, bufnr)
end

M.on_init = function(client, _)
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

return M
