return {
  'akinsho/bufferline.nvim',
  version = '*',
  cond = not vim.g.vscode,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Explorer',
          highlight = 'Directory',
          separator = true,
        },
      },
    },
  },
}
