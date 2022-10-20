if exists('g:vscode')
    source ~/.vim/conf/vscode.vim
else
    lua require('core.init')

    set undofile                
    set undodir=$HOME/.vim/undo
    set undolevels=1000
    set undoreload=10000
    set nowrap

    let path = expand('<sfile>:p:h')
    exec 'source' path . '/vim/buffer.vim'

    set clipboard^=unnamed,unnamedplus
endif
