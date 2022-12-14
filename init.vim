let path = expand('<sfile>:p:h')

if exists('g:vscode')
    exec 'source' path . '/vim/vscode.vim'
else
    lua require('core.init')

    set undodir=$HOME/.config/nvim/undo
    set nowrap
    set clipboard^=unnamed,unnamedplus

    exec 'source' path . '/vim/buffer.vim'
endif
