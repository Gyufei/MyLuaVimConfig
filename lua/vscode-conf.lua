local vscode = require('vscode')
local map = vim.keymap.set

local function call(command)
  return function()
    vscode.call(command)
  end
end

-- System clipboard
map('n', '<leader>p', '"+p')
map('n', '<leader>P', '"+P')
map('v', '<leader>p', '"+p')
map('v', '<leader>P', '"+P')
map('v', '<leader>y', '"+y')
map('v', '<leader>d', '"+d')

-- Search and file actions
map('n', '<leader>/', function()
  vscode.action('workbench.action.findInFiles', {
    args = { query = vim.fn.expand('<cword>') },
  })
end)
map('n', '<leader>w', call('workbench.action.files.save'))
map('n', '<leader>q', call('workbench.action.closeActiveEditor'))
map('n', '<leader>Q', call('workbench.action.closeAllEditors'))
map('n', '<leader>bm', call('workbench.action.closeOtherEditors'))

-- Editor navigation
for index = 1, 9 do
  map('n', '<leader>' .. index, call('workbench.action.openEditorAtIndex' .. index))
end

map('n', '<C-j>', call('workbench.action.previousEditor'))
map('n', '<C-k>', call('workbench.action.nextEditor'))
map({ 'n', 'v' }, '<C-h>', call('workbench.files.action.showActiveFileInExplorer'))

-- IDE actions
map('n', '<leader>ee', call('editor.action.quickFix'))
map('n', '<leader>rn', call('editor.action.rename'))
