return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  cond = not vim.g.vscode,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.o.laststatus = 3
    vim.o.showmode = false
  end,
  opts = {
    options = {
      theme = 'gruvbox',
      globalstatus = true,
      disabled_filetypes = {
        statusline = { 'neo-tree' },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        {
          'diagnostics',
          symbols = {
            error = 'E ',
            warn = 'W ',
            info = 'I ',
            hint = 'H ',
          },
        },
        { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        { 'filename', path = 1 },
      },
      lualine_x = {
        {
          'diff',
          symbols = {
            added = '+',
            modified = '~',
            removed = '-',
          },
        },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {
        { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
        { 'location', padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        function()
          return os.date('%R')
        end,
      },
    },
    extensions = { 'neo-tree', 'lazy' },
  },
}
