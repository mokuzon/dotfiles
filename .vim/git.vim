set nocompatible
set colorcolumn=80,128
set ruler
set synmaxcol=300
set textwidth=0

source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')
  "" Appearance
  Plug 'w0ng/vim-hybrid' " color scheme
  Plug 'itchyny/lightline.vim'  " upgrade status bar
  Plug 'cocopon/lightline-hybrid.vim' "status bar color scheme
  Plug 'Yggdroot/indentLine' " indent guide
  Plug 'bronson/vim-trailing-whitespace'  " highlight unused white space
call plug#end()

let g:hybrid_custom_term_colors = 1
colorscheme hybrid
set t_Co=256
set background=dark
hi Normal ctermbg=none
hi CursorLine ctermbg=235
hi ColorColumn ctermbg=235
hi VertSplit ctermbg=237 ctermfg=239
hi LineNr ctermbg=235 ctermfg=243
hi CursorLineNr term=bold ctermfg=255
hi Visual ctermbg=1
hi Comment ctermfg=243
hi SearchCurrent ctermfg=255 ctermbg=32

noremap <C-p> <Up>
noremap <C-n> <Down>
noremap <C-b> <Left>
noremap <C-f> <Right>
noremap <C-a> <home>
noremap <C-e> <End>
noremap <C-d> <Del>
noremap <C-h> <BS>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

nmap j gj
nmap k gk
vmap j gj
vmap k gk

vnoremap y "*y
nnoremap yy "*yy
nnoremap P "*p
