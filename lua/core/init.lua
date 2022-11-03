-- basics
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.opt.showmatch      = true
vim.opt.autoread    = true
vim.opt.autowrite      = true

vim.opt.number         = true
vim.opt.relativenumber = true
-- vim.opt.nuw            = 6
vim.opt.cursorline     = true
vim.opt.showcmd     = true

vim.opt.confirm = true
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.shortmess = "atI"
vim.opt.helplang = 'CN'
vim.opt.encoding = 'utf-8'

vim.opt.wrap = false
vim.opt.wrapscan    = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.iskeyword:append {'_', '$', '@', '%', '#', '-'}
vim.opt.matchtime = 1

vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.scrolloff = 3
vim.opt.termguicolors  = true
vim.opt.updatetime     = 100
vim.opt.backspace = "indent,eol,start"
vim.opt.selection = "exclusive"
vim.opt.selectmode = "mouse,key"
vim.opt.signcolumn = "yes:1"

-- tabs
vim.opt.smarttab   = true
vim.opt.smartindent = true
vim.opt.autoindent    = true
vim.opt.expandtab     = true
vim.opt.shiftround     = true
vim.opt.shiftwidth    = 4
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4

vim.opt.mouse        = 'a'

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "NotoMono Nerd Font Mono"

require("core.keymaps")
require("core.plugins")

-- disable some useless standard plugins to save startup time
-- these features have been better covered by plugins
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

require("impatient")
require("configs.cmp").config()
require("configs.lspconfig").config()
require("configs.nullls").config()

require("configs.nvimtree").config()
require("configs.treesitter").config()
require("configs.lualine").config()
require("configs.bufferline").config()
require("configs.terminal").config()
require("configs.telescope").config()
require("configs.other").config()

