local M = {}
function M.config()
    -- nvim-tree config
    require 'nvim-tree'.setup {
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


local function open_nvim_tree()
  -- always open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return M
