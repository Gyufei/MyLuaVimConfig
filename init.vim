
if exists('g:vscode')
    let path = expand('<sfile>:p:h')
    exec 'source' path . '/vim/vscode.vim'
else
    lua require('core.init')

    set undodir=$HOME/.config/nvim/undo
    set nowrap
    set clipboard^=unnamed,unnamedplus
endif
