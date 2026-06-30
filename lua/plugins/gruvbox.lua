return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  cond = not vim.g.vscode,
  config = function()
    require('gruvbox').setup({
      contrast = 'medium',
      transparent_mode = false,
    })
    vim.cmd.colorscheme('gruvbox')
  end,
}
