vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.autoformat = true

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

local opt = vim.opt

opt.autoread = true
opt.autowrite = true
opt.autowriteall = false
opt.autoindent = true
opt.backspace = 'indent,eol,start'
opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus'
opt.cmdheight = 1
opt.completeopt = 'menu,menuone,noselect'
opt.confirm = true
opt.cursorline = true
opt.encoding = 'utf-8'
opt.expandtab = true
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.foldlevel = 99
opt.foldmethod = 'indent'
opt.foldtext = ''
opt.formatoptions = 'jcroqlnt'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.helplang = 'CN'
opt.history = 1000
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.incsearch = true
opt.iskeyword:append('_,$,@,%,#,-')
opt.jumpoptions = 'view'
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.matchtime = 1
opt.mouse = 'a'
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4
opt.selectmode = 'mouse,key'
opt.selection = 'inclusive'
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = 'atI'
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showcmd = true
opt.showmatch = true
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.smoothscroll = true
opt.softtabstop = 2
opt.spelllang = { 'en' }
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.undofile = true
opt.undolevels = 10000
opt.undoreload = 10000
opt.updatetime = 200
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = false
opt.wrapscan = true

vim.g.markdown_recommended_style = 0

vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
