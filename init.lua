require('config.options')
require('config.autocmds')
require('config.keymaps')

require('config.lazy')

if vim.g.vscode then
  require('vscode-conf')
  return
end
