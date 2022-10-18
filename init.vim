lua require('core.init')

let path = expand('<sfile>:p:h')
exec 'source' path . '/vim/buffer.vim'

set clipboard^=unnamed,unnamedplus