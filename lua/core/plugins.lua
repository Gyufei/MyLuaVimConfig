-- packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use "ellisonleao/gruvbox.nvim"
  use 'asvetliakov/vim-easymotion'
  use 'tpope/vim-surround'
  use 'unblevable/quick-scope'
  use 'tzachar/local-highlight.nvim'
end)
