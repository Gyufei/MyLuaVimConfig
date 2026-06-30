return {
  'nvim-mini/mini.move',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('mini.move').setup(opts)
  end,
}
