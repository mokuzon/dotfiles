lan en_US.UTF-8
set backupdir=~/.vim/tmp
set belloff=all
set hidden
set mouse=a
set modifiable
set noswapfile
set autoread

" tab
filetype plugin indent on
set backspace=indent,eol,start
set tabstop=2
set autoindent
set smartindent
set expandtab
set shiftwidth=2

" window split method
set splitbelow
set splitright

"" Plugins
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundle')
  call dein#begin('~/.vim/bundle')
  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

  call dein#add('w0ng/vim-hybrid') " color scheme
  call dein#add('luochen1990/rainbow') " highliht pair branckets
  call dein#add('itchyny/lightline.vim')  " upgrade status bar
  call dein#add('cocopon/lightline-hybrid.vim') "status bar color scheme
  call dein#add('Yggdroot/indentLine') " indent guide
  call dein#add('bronson/vim-trailing-whitespace')  " highlight unused white space
  call dein#add('ap/vim-buftabline') " make buffer visible like tabs

  " CoC
  call dein#add('neoclide/coc.nvim', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-highlight', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-tsserver', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-eslint', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-prettier', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-solargraph', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-html', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-css', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('antoinemadec/coc-fzf', { 'build': 'yarn install --frozen-lockfile' })

  " Utility
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('907th/vim-auto-save') " auto save
  call dein#add('tomtom/tcomment_vim')  " comment out
  call dein#add('preservim/nerdtree')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('airblade/vim-gitgutter')

  " Ruby
  call dein#add('tpope/vim-endwise')
  call dein#add('rlue/vim-fold-rspec')
  call dein#add('tpope/vim-rails')
  call dein#add('vim-scripts/ruby-matchit')

  " Jsonnet
  call dein#add('google/vim-jsonnet')

  call dein#end()
  call dein#save_state()
endif

nmap <silent> <C-]> <Plug>(coc-definition)

let $FZF_DEFAULT_OPTS='--extended --layout=reverse --cycle'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

noremap <silent> fb :Buffers<CR>
noremap <silent> ff :Files<CR>
noremap <silent> fg :GFiles?<CR>
noremap <silent> fh :History<CR>
noremap <silent> fr :Rg <C-R><C-W><CR>

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ['InsertLeave', 'CursorHold']
set updatetime=100

let g:fold_rspec_foldenable = 0
let g:fold_rspec_foldclose = 'all'
let g:fold_rspec_foldminlines = 2
let g:fold_rspec_foldlevel = 2

"" filetypes
au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
au BufRead,BufNewFile *.iam set filetype=ruby
au FileType json syntax match Comment +\/\/.\+$+ " allow comment syntax for json

"" appearance
syntax on
set background=dark
set colorcolumn=80,128
set number
set ruler
set synmaxcol=300
set t_Co=256

let g:hybrid_custom_term_colors = 1
colorscheme hybrid

hi Normal ctermbg=none
hi CursorLine ctermbg=33 ctermfg=255
hi ColorColumn ctermbg=236
hi VertSplit ctermbg=237 ctermfg=239
hi LineNr ctermbg=236 ctermfg=243
hi CursorLineNr term=bold ctermfg=255
hi Visual ctermbg=1
hi Comment ctermfg=243
hi Pmenu ctermfg=white ctermbg=8
hi PmenuSel ctermfg=32 ctermbg=220
hi SearchCurrent ctermfg=255 ctermbg=32
hi GitGutterAdd    ctermfg=64 ctermbg=149
hi GitGutterChange ctermfg=3 ctermbg=227
hi GitGutterDelete ctermfg=1 ctermbg=9

let g:indentLine_fileTypeExclude = ['help', 'startify']
let g:indentLine_faster = 1

hi BufTabLineCurrent ctermfg=220 ctermbg=242
hi BufTabLineActive ctermfg=231 ctermbg=242
hi BufTabLineHidden ctermfg=231 ctermbg=238
hi BufTabLineFill ctermbg=237

set laststatus=2

hi NERDTreeDir ctermfg=110
hi NERDTreeUp ctermfg=9
hi NERDTreeDirSlash ctermfg=110
hi NERDTReeCWD ctermfg=14

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "!",
  \ "Staged"    : "+",
  \ "Untracked" : "N",
  \ "Renamed"   : "R",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "D",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ "Unknown"   : "?"
\ }

let NERDTreeShowHidden = 1  " show hidden files
let NERDTreeWinSize = 45
let g:NERDTreeMapJumpNextSibling = ''

set autoread
augroup checktime
  au!
  autocmd BufEnter        * silent! checktime
  autocmd CursorHold      * silent! checktime
  autocmd CursorHoldI     * silent! checktime
augroup END

let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'filename' ] ]
\ },
\ 'component_function': {
\   'fugitive': 'LightLineFugitive',
\   'readonly': 'LightLineReadonly',
\   'modified': 'LightLineModified',
\   'filename': 'LightLineFilename'
\ },
\ 'colorscheme': 'hybrid'
\ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
    elseif &readonly
    return "readonly"
    else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? branch : ''
  endif
  return ''
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . '' : '') .
   \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
   \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

let g:rainbow_active = 1

"" keymap
noremap <C-t> <Nop> " for tmux
imap <CR> <C-R>=pumvisible() && complete_info()['selected'] != -1 ? '<C-y>' : "\n"<CR>

nnoremap <M-p> :call Openpr()<CR>
nnoremap <M-g> :Gbrowse master:%<CR>
nnoremap <M-n> :NERDTreeToggle<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" buffer
nnoremap <S-k> :bn<CR>
nnoremap <S-j> :bp<CR>
nnoremap <S-x> :bp<CR>:bd #<CR>


inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

noremap <C-p> <Up>
noremap <C-n> <Down>
noremap <C-b> <Left>
noremap <C-f> <Right>
noremap <C-a> <home>
noremap <C-e> <End>
noremap <C-d> <Del>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <home>
inoremap <C-e> <End>
inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

vnoremap y "*y
nnoremap yy "*yy
nnoremap P "*p

inoremap <silent> jj <ESC>

"" locad local rc
runtime! local.vim
