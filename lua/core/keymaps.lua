vim.g.mapleader = " "

vim.keymap.set('i', '<C-b>', '<ESC>^i')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')


vim.keymap.set('n', '<leader>w', '<cmd> w <CR>')
vim.keymap.set('n', '<leader>q', '<cmd> Bdelete <CR>')

-- f: file tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')

-- y: telescope
vim.keymap.set({ 'n', 'i' }, '<C-p>', function() require 'telescope.builtin'.find_files {} end)
vim.keymap.set('n', '<leader>f', "<cmd> Telescope find_files <CR>")
vim.keymap.set('n', '<leader>/', "<cmd> Telescope live_grep <CR>")

-- b: buffer
vim.keymap.set('n', '<leader>bb', ':BufferLinePick <CR>')
vim.keymap.set('n', '<TAB>', ':BufferLineCycleNext <CR>')
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev <CR>')

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>le', ':Lspsaga show_line_diagnostics<cr>')
vim.keymap.set('n', '<leader>lE', ':Lspsaga show_cursor_diagnostics<cr>')
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>ld', ':Lspsaga peek_definition<cr>')
vim.keymap.set('n', '<leader>lr', ':Lspsaga rename<cr>')
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting)
vim.keymap.set('n', '<leader>lb', ':SymbolsOutline<cr>')
vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<cr>')
vim.keymap.set('n', '<leader>lu', ':Lspsaga lsp_finder<cr>')
vim.keymap.set('n', '<F12>', ':Lspsaga code_action<cr>')
vim.keymap.set('n', '<f4>', ':SymbolsOutline<cr>')
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>gp', ':Lspsaga diagnostic_jump_prev<cr>')
vim.keymap.set('n', '<leader>gn', ':Lspsaga diagnostic_jump_next<cr>')
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references)