-- packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- starup time optimise
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'

  -- themes
  -- use 'projekt0n/github-nvim-theme'
  use "ellisonleao/gruvbox.nvim"

  use {
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons'
  }

-- language
use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

use 'glepnir/lspsaga.nvim'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'
use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'

use 'nvim-treesitter/nvim-treesitter'

-- git
use {
  'lewis6991/gitsigns.nvim',
  tag = 'release',
}

use {
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons'
}

use {
  "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
}

-- status line
use {
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons'
}

-- floating terminal
use 'akinsho/toggleterm.nvim'

-- file telescope
use {
  "jose-elias-alvarez/null-ls.nvim",
  requires = 'nvim-lua/plenary.nvim'
}
use {
  'nvim-telescope/telescope.nvim',
  requires = 'nvim-lua/plenary.nvim'
}

use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use 'windwp/nvim-spectre'
use "windwp/nvim-autopairs"
use "kylechui/nvim-surround"
--  esay motion
use "phaazon/hop.nvim"

use "lukas-reineke/indent-blankline.nvim"
use 'numToStr/Comment.nvim'
-- use 'moll/vim-bbye'
use 'kazhala/close-buffers.nvim'

use {'kevinhwang91/nvim-bqf'}
end)
