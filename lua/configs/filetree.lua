local M = {}
function M.config()
    -- nvim-tree config
    require 'nvim-tree'.setup {
        open_on_setup        = true,
        update_focused_file  = {
            enable           = true,
            update_root      = true
        },
        filters              = {
            dotfiles = true,
        },
        git                  = {
            enable = true,
            ignore = false,
        },
        view                 = {
            width = 30,
        },
        trash                = {
            cmd = "trash"
        },
        actions              = {
            change_dir = {
                global = false
            },
        }
    }
end

return M
