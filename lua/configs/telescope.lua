local M = {}
function M.config()
    local telescope = require("telescope")
    local trouble = require("trouble")

    trouble.setup({})

    local troubleT = require("trouble.providers.telescope")

    telescope.setup({
        defaults = {
            mappings = {
                    i = {
                    ["<C-j>"] = require('telescope.actions').cycle_history_prev,
                    ["<C-k>"] = require('telescope.actions').cycle_history_next,
                    ["<c-t>"] = troubleT.open_with_trouble
                },
                n = { ["<c-t>"] = troubleT.open_with_trouble },
            },
            layout_strategy = 'vertical',
            layout_config = { height = 0.95 },
            file_ignore_patterns = { '^dist/', '^pnpm-lock.yaml$', '^package-lock.json$', '^yarn.lock$'},
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    })

    telescope.load_extension('fzf')
end

return M
