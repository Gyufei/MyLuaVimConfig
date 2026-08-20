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
      lualine_b = {},
      lualine_c = {
        { 'filename', path = 1 },
      },
      lualine_x = { 'filetype' },
      lualine_y = {},
      lualine_z = { 'location' },
    },
    extensions = { 'neo-tree', 'lazy' },
  },
}
