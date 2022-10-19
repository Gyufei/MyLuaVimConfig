local M = {}
function M.config()
    local servers = { "html", "cssls", "tsserver", "tailwindcss", "jsonls", "eslint", "volar", "sumneko_lua", "vimls"}

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

    for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = servers
    })
end

return M
