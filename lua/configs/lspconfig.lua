local M = {}
function M.config()
    -- local servers = { "html", "cssls", "tsserver", "eslint", "tailwindcss", "jsonls", "volar", "sumneko_lua", "vimls"}
    local servers = { "html", "cssls", "tsserver", "eslint", "jsonls", "volar", "sumneko_lua", "vimls"}

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = servers
    })

    local function on_attach (client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
        snippetSupport = true,
        documentationFormat = { "markdown", "plaintext" },
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        },
    }

    require("mason-lspconfig").setup_handlers {
        function (server_name)
            require("lspconfig")[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    }

    local saga = require 'lspsaga'
    saga.init_lsp_saga({})
end

return M
