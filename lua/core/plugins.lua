-- packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- starup time optimise
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'
  -- themes
  use "ellisonleao/gruvbox.nvim"
  use 'nvim-treesitter/nvim-treesitter'

  -- language
  use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig", }
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use { "jose-elias-alvarez/null-ls.nvim", requires = 'nvim-lua/plenary.nvim' }

  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  use { 'lewis6991/gitsigns.nvim', tag = 'release', }
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }
  use 'kevinhwang91/nvim-bqf'

  -- global replace
  -- use 'windwp/nvim-spectre'
  -- term
  -- use 'akinsho/toggleterm.nvim'

  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use 'numToStr/Comment.nvim'
  use "lukas-reineke/indent-blankline.nvim"

  --hilight current word
  use 'tzachar/local-highlight.nvim'
  use 'kazhala/close-buffers.nvim'

  use 'm4xshen/autoclose.nvim'
  use "kylechui/nvim-surround"
  use "phaazon/hop.nvim"

  -- emacs edit key like c-w,c-h
  use "linty-org/readline.nvim"
end)
