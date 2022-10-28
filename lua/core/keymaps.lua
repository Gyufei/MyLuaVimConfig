vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set('i', '<C-b>', '<ESC>^i')
keymap.set('i', '<C-e>', '<End>')
keymap.set('i', '<C-h>', '<Left>')
keymap.set('i', '<C-l>', '<Right>')
keymap.set('i', '<C-j>', '<Down>')
keymap.set('i', '<C-k>', '<Up>')

keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-l>', '<C-w>l')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')


keymap.set('n', '<leader>w', '<cmd> w <CR>')
keymap.set('n', '<leader>q', '<cmd> Bdelete <CR>')
keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

-- f: file tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')

-- y: telescope
keymap.set({ 'n', 'i' }, '<C-p>', function() require 'telescope.builtin'.find_files {} end)
keymap.set('n', '<leader>/', "<cmd> Telescope live_grep <CR>")
keymap.set('n', 'K', "<cmd> Telescope grep_string <CR>")
keymap.set('n', '<leader>ff', "<cmd> Telescope find_files <CR>")

-- vim.keymap.set('n', '<leader>fgc', "<cmd> Telescope git_commits <CR>")
-- vim.keymap.set('n', '<leader>fgs', "<cmd> Telescope git_status <CR>")
-- vim.keymap.set('n', '<leader>fgb', "<cmd> Telescope git_branches <CR>")
-- vim.keymap.set('n', '<leader>fb', "<cmd> Telescope buffers <CR>")
-- vim.keymap.set('n', '<leader>fo', "<cmd> Telescope oldfiles <CR>")
-- vim.keymap.set('n', '<leader>fv', "<cmd> Telescope treesitter <CR>")

-- b: buffer
keymap.set('n', '<leader>bb', ':BufferLinePick <CR>')
keymap.set('n', '<TAB>', ':BufferLineCycleNext <CR>')
keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev <CR>')

keymap.set('n', 'H', vim.lsp.buf.hover)
keymap.set('n', 'gd', vim.lsp.buf.definition)
keymap.set('n', 'gD', vim.lsp.buf.declaration)
keymap.set('n', 'gt', vim.lsp.buf.type_definition)
keymap.set('n', 'gi', vim.lsp.buf.implementation)
keymap.set('n', 'gr', vim.lsp.buf.references)
-- lsp
keymap.set('n', '<leader>la', ':Lspsaga code_action<cr>')
keymap.set('n', '<leader>le', ':Lspsaga show_line_diagnostics<cr>')
keymap.set('n', '<leader>lE', ':Lspsaga show_cursor_diagnostics<cr>')
keymap.set('n', '<leader>lr', ':Lspsaga rename<cr>')

keymap.set('n', '<leader>ld', ':Lspsaga peek_definition<cr>')
-- use <C-t> to jump back
keymap.set('n', '<leader>ll', ':Lspsaga lsp_finder<cr>')
keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help)
keymap.set('n', '<leader>lf', vim.lsp.buf.formatting)
keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)
-- Outline
keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", { silent = true })

keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

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
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end
)

