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
            file_ignore_patterns = { '^dist/', 'pnpm-lock.yaml' },
        }
    })
    require('telescope').load_extension('fzf')
end

return M
