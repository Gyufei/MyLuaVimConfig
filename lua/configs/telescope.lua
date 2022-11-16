local M = {}
function M.config()
    require("telescope").setup({
        defaults = {
            mappings = {
                    i = {
                    ["<C-j>"] = require('telescope.actions').cycle_history_prev,
                    ["<C-k>"] = require('telescope.actions').cycle_history_next,
                },
            },
            file_ignore_patterns = { '^dist/', 'pnpm-lock.yaml', 'package-lock.json', 'yarn.lock'},
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
    require('telescope').load_extension('fzf')
end

return M
