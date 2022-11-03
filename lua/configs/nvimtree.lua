local M = {}
function M.config()
    -- nvim-tree config
    require 'nvim-tree'.setup {
        open_on_setup        = true,
        hijack_unnamed_buffer_when_opening = true,
        update_focused_file  = {
            enable           = true,
            update_root      = true
        },
        filters              = {
            custom = { "^\\.git$", "^.DS_Store" }
        },
        git                  = {
            enable = true,
            ignore = false,
        },
        view                 = {
            width = 30,
            hide_root_folder = true,
        },
        trash                = {
            cmd = "trash"
        },
        actions              = {
            change_dir = {
                global = false
            },
            open_file = {
                -- window_picker = {
                --     enable = false,
                -- },
            }
        }
    }
end

return M
