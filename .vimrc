" bin
let g:python_host_prog = $HOME.'/.pyenv/versions/2.7.15/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/3.6.5/bin/python'

" locad devided setting files
runtime! my_autoload/*.vim

" split setting
set splitbelow
set splitright

" beep
set ttimeoutlen=10
set belloff=all

" editor
lan en_US.UTF-8
set nocompatible

set number

set hidden

" tab
filetype plugin indent on
set backspace=indent,eol,start
set tabstop=2
set autoindent
set smartindent
set expandtab
set shiftwidth=2

" iskeyword
set iskeyword-=.
set iskeyword+=-
set iskeyword+=@-@
set iskeyword+=?

" backup
set backupdir=~/.vim/tmp
set noswapfile

" enable mouse support
set mouse=a

"enable window resize
set modifiable

if has('nvim')
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
else
  autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
endif
