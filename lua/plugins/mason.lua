return {
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    cond = not vim.g.vscode,
    build = ':MasonUpdate',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = {
      ui = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
}
