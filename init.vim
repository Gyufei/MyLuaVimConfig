if exists('g:vscode')
    source ~/.vim/conf/vscode.vim
else
    lua require('core.init')

    set undodir=$HOME/.vim/undo
    set nowrap
    set clipboard^=unnamed,unnamedplus

    let path = expand('<sfile>:p:h')
    exec 'source' path . '/vim/buffer.vim'
endif
