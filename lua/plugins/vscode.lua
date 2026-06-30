if not vim.g.vscode then
  return {}
end

local enabled = {
  'dial.nvim',
  'flash.nvim',
  'lazy.nvim',
  'mini.ai',
  'mini.comment',
  'mini.move',
  'mini.pairs',
  'mini.surround',
  'nvim-treesitter',
  'nvim-treesitter-textobjects',
  'nvim-ts-context-commentstring',
  'yanky.nvim',
}

local config = require('lazy.core.config')
config.options.checker.enabled = false
config.options.change_detection.enabled = false
config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      highlight = { enable = false },
      folds = { enable = false },
    },
  },
}
