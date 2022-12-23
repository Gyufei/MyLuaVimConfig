local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set('i', '<C-b>', '<ESC>^i')
keymap.set('i', '<C-e>', '<End>')
keymap.set('i', '<C-l>', '<Right>')
keymap.set('i', '<C-j>', '<Down>')
keymap.set('i', '<C-k>', '<Up>')

keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-l>', '<C-w>l')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')


keymap.set('n', '<leader>w', '<cmd> w <CR>')
keymap.set('n', '<leader>Q', '<cmd> :bd <CR>')
keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

