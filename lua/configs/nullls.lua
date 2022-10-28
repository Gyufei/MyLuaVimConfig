local M = {}
function M.config()
    require("null-ls").setup({
        diagnostics_format = "[#{c}] #{m} (#{s})",
        sources = {

            require("null-ls").builtins.code_actions.eslint_d,
            require("null-ls").builtins.formatting.eslint_d,
            require("null-ls").builtins.diagnostics.eslint_d,

            require("null-ls").builtins.diagnostics.tsc

            -- require("null-ls").builtins.code_actions.eslint,
            -- require("null-ls").builtins.formatting.eslint,
            -- require("null-ls").builtins.diagnostics.eslint,
            -- require("null-ls").builtins.diagnostics.tsc,
            -- require("null-ls").builtins.formatting.prettierd
        },
    })
end

return M
