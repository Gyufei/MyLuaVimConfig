local M = {}
function M.config()
    local condition = function (utils)
        return utils.root_has_file({
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.yaml",
            ".eslintrc.yml",
            ".eslintrc.json",
        })
    end

    require("null-ls").setup({
        diagnostics_format = "#{m} (#{s})",
        sources = {
            -- require("null-ls").builtins.code_actions.eslint_d.with({
            --     condition = condition
            -- }),
            -- require("null-ls").builtins.formatting.eslint_d.with({
            --     condition = condition
            -- }),
            -- require("null-ls").builtins.diagnostics.eslint_d.with({
            --     condition = condition
            -- }),
            --
            -- require("null-ls").builtins.diagnostics.tsc

            -- require("null-ls").builtins.code_actions.eslint,
            -- require("null-ls").builtins.formatting.eslint,
            -- require("null-ls").builtins.diagnostics.eslint,
            -- require("null-ls").builtins.diagnostics.tsc,
            -- require("null-ls").builtins.formatting.prettierd
            require("null-ls").builtins.formatting.prettierd.with({
              condition = function(utils)
                return utils.root_has_file({ ".prettierrc.js"})
              end,
            }),
        },
    })
end

return M
