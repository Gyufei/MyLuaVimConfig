-- packer.nvim
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

	-- starup time optimise
	use 'lewis6991/impatient.nvim'
	use 'nathom/filetype.nvim'

	use {
		'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons'
	}
	use 'moll/vim-bbye' -- for more sensible delete buffer cmd

	-- themes
    use 'projekt0n/github-nvim-theme'

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
	use 'nvim-treesitter/nvim-treesitter'

	-- git
	use {
		'lewis6991/gitsigns.nvim',
		tag = 'release',
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

    use "windwp/nvim-autopairs"

	-- indent guide
	use "lukas-reineke/indent-blankline.nvim"

    use 'numToStr/Comment.nvim'
end)
