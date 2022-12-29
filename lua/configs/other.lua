local M = {}
function M.config()
    require('gitsigns').setup({
      current_line_blame = true
    })

    require("gruvbox").setup({})

    require("autoclose").setup({})
    require('Comment').setup()
    require("nvim-surround").setup()
    require('spectre').setup()

    require('hop').setup()
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, {remap=true})
    vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, {remap=true})
    vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, {remap=true})
    vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, {remap=true})
    vim.keymap.set('', '<leader><leader>j', function()
        hop.hint_lines_skip_whitespace({})
    end, {remap=true})
    vim.keymap.set('', '<leader><leader>k', function()
        hop.hint_words({})
    end, {remap=true})

    require('bqf').setup({})

    require('close_buffers').setup({
      preserve_window_layout = { 'this', 'nameless' },  -- Types of deletion that should preserve the window layout
      next_buffer_cmd = function(windows)
        require('bufferline').cycle(1)
        local bufnr = vim.api.nvim_get_current_buf()

        for _, window in ipairs(windows) do
          vim.api.nvim_win_set_buf(window, bufnr)
        end
      end,
    })
end

return M
