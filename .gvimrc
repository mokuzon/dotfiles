set guifont=Inconsolata\ for\ Powerline:h13
set enc=utf8

colorscheme hybrid
set t_Co=256
set background=dark
set hlsearch

set colorcolumn=80,128
let g:terminal_ansi_colors = [
      \ '#2D3C46', '#A54242', '#8C9440', '#DE935F',
      \ '#5F819D', '#85678F', '#5E8D87', '#6C7A80',
      \ '#425059', '#CC6666', '#B5BD68', '#F0C674',
      \ '#81A2BE', '#B294BB', '#8ABEB7', '#C5C8C6',
      \ ]

hi Normal guibg=#2B2B2B
hi ColorColumn guibg=#262626
hi CursorColumn guibg=#262626
hi VertSplit guibg=#3a3a3a guifg=#4e4e4e
hi LineNr guibg=#262626 guifg=#767676
hi CursorLineNr term=bold guifg=#eeeeee
hi Visual guibg=#800000
hi Comment guifg=#767676
hi NERDTreeDir guifg=#87afd7
hi NERDTreeUp guifg=#ff0000
hi NERDTreeDirSlash guifg=#87afd7
hi NERDTReeCWD guifg=#00ffff
hi Pmenu guifg=white guibg=#808080
hi PmenuSel guifg=#0087d7 guibg=#ffdf00
hi BufTabLineCurrent guifg=#ffdf00 guibg=#6c6c6c
hi BufTabLineActive guifg=#ffffff guibg=#6c6c6c
hi BufTabLineHidden guifg=#ffffff guibg=#444444
hi BufTabLineFill guibg=#3a3a3a
hi SearchCurrent guibg=#1270ce guifg=white

set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=
set guioptions-=b

" set transparency=5
set showtabline=2
au GUIEnter * winpos 0 0
set lines=160 columns=280

set macmeta
set imdisable

" let $PYTHONHOME=$HOME."/.pyenv/versions/2.7.15"
" set pythondll=$HOME/.pyenv/versions/2.7.15/lib/libpython2.7.dylib
" py import sys
let $PYTHONHOME=$HOME."/.pyenv/versions/3.6.5"
set pythonthreedll=$HOME/.pyenv/versions/3.6.5/lib/libpython3.6m.dylib
py3 import sys
let $RUBYHOME=$HOME."/.rbenv/versions/2.5.1"
set rubydll=$HOME/.rbenv/versions/2.5.1/lib/libruby.2.5.1.dylib

set imdisable

noremap ; :
noremap : ;
inoremap ; :
inoremap : ;
vnoremap ; :
vnoremap : ;
cnoremap ; :
cnoremap : ;
