local keymap = vim.keymap

keymap.set('!', '<C-f>', '<Right>')

-- buffer delete
keymap.set('n', '<leader>q', ":BDelete this<CR>")
keymap.set('n', '<leader>bm', ":BDelete other<CR>")

-- t: file tree
keymap.set('n', '<leader>t', '<cmd> NvimTreeToggle <CR>')

-- f: telescope
keymap.set({ 'n', 'i' }, '<C-p>', "<cmd> Telescope find_files <CR>")
keymap.set('n', '<leader>/', "<cmd> Telescope live_grep <CR>")
keymap.set('n', 'K', "<cmd> Telescope grep_string <CR>")
keymap.set('n', '<leader>gc', "<cmd> Telescope git_bcommits <CR>")
keymap.set('n', '<leader>gs', "<cmd> Telescope git_status <CR>")
-- keymap.set('n', '<leader>fgc', "<cmd> Telescope git_commits <CR>")
-- keymap.set('n', '<leader>fgb', "<cmd> Telescope git_branches <CR>")
-- keymap.set('n', '<leader>fb', "<cmd> Telescope buffers <CR>")
-- keymap.set('n', '<leader>fo', "<cmd> Telescope oldfiles <CR>")
-- keymap.set('n', '<leader>fv', "<cmd> Telescope treesitter <CR>")


--s :Spectre search replace
keymap.set("n", "<leader>sr", "<cmd>lua require('spectre').open()<CR>")
keymap.set("v", "<leader>sr", "<esc>:lua require('spectre').open_visual()<CR>")
-- search current word
keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
-- search in current file
keymap.set("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<CR>")

-- b: bufferLine
keymap.set('n', '<leader>bb', ':BufferLinePick <CR>')
keymap.set('n', '<TAB>', ':BufferLineCycleNext <CR>')
keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev <CR>')
keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
keymap.set('n', '<leader>$', '<Cmd>BufferLineGoToBuffer -1<CR>')

-- l: lsp
keymap.set('n', 'H', vim.lsp.buf.hover)
keymap.set('n', 'gd', vim.lsp.buf.definition)
keymap.set('n', 'gr', vim.lsp.buf.references)
-- keymap.set('n', 'gD', vim.lsp.buf.declaration)
-- keymap.set('n', 'gt', vim.lsp.buf.type_definition)
-- keymap.set('n', 'gi', vim.lsp.buf.implementation)

-- lsp
keymap.set('n', '<leader>rn', ':Lspsaga rename<cr>')
keymap.set('n', '<leader>lf', vim.lsp.buf.format)
-- keymap.set('n', '<leader>lE', ':Lspsaga show_cursor_diagnostics<cr>')

-- use <C-t> to jump back
keymap.set('n', '<leader>ll', ':Lspsaga lsp_finder<cr>')
keymap.set('n', '<leader>ld', ':Lspsaga peek_definition<cr>')
keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help)
keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)

-- diagnostic and error
keymap.set("n", "<leader>ee", "<cmd> TroubleToggle document_diagnostics <CR>")
keymap.set('n', '<leader>el', ':Lspsaga show_line_diagnostics<cr>')
keymap.set('n', '<leader>ea', ':Lspsaga code_action<cr>')
keymap.set("n", "[e", "<cmd> Lspsaga diagnostic_jump_prev <CR>", { silent = true })
keymap.set("n", "]e", "<cmd> Lspsaga diagnostic_jump_next <CR>", { silent = true })
keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- git
keymap.set('n', '<leader>gv',
  function()
    require("gitsigns").preview_hunk()
  end
)
keymap.set('n', "]c",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
            require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end
)

keymap.set('n', "[c",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end
)


