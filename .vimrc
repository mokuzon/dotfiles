lan en_US.UTF-8
set backupdir=~/.vim/tmp
set belloff=all
set hidden
set mouse=a
set modifiable
set noswapfile

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
source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')
" Appearance
Plug 'w0ng/vim-hybrid' " color scheme
Plug 'itchyny/lightline.vim'  " upgrade status bar
Plug 'cocopon/lightline-hybrid.vim' "status bar color scheme
Plug 'Yggdroot/indentLine' " indent guide
Plug 'bronson/vim-trailing-whitespace'  " highlight unused white space
Plug 'ap/vim-buftabline' " make buffer visible like tabs

" CoC
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neoclide/coc-highlight', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-prettier', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-solargraph', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-html', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-css', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tabnine', { 'do': 'yarn install --frozen-lockfile' }
Plug 'antoinemadec/coc-fzf', { 'do': 'yarn install --frozen-lockfile' }

" Utility
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug '907th/vim-auto-save' " auto save
Plug 'tomtom/tcomment_vim'  " comment out
Plug 'preservim/nerdtree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Terraform
Plug 'fatih/vim-hclfmt'
call plug#end()

let g:plug = {
\ "plugs": get(g:, 'plugs', {})
\ }

function! g:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

if g:plug.is_installed('coc.nvim')
  nmap <silent> <C-]> <Plug>(coc-definition)
endif

if g:plug.is_installed('fzf.vim')
  let $FZF_DEFAULT_OPTS='--extended --layout=reverse --cycle'
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

  noremap <silent> fb :Buffers<CR>
  noremap <silent> ff :Files<CR>
  noremap <silent> fg :GFiles?<CR>
  noremap <silent> fh :History<CR>
  noremap <silent> fr :Rg <C-R><C-W><CR>
endif

if g:plug.is_installed('vim-auto-save')
  let g:auto_save = 1
  let g:auto_save_silent = 1
  let g:auto_save_events = ['InsertLeave', 'CursorHold']
  set updatetime=100
endif

if g:plug.is_installed('nerdtree')
  nnoremap <A-n> :NERDTreeToggle<CR>
endif

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

if g:plug.is_installed('vim-hybrid')
  let g:hybrid_custom_term_colors = 1
  colorscheme hybrid
endif

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

if g:plug.is_installed('indentLine')
  let g:indentLine_fileTypeExclude = ['help', 'startify']
  let g:indentLine_faster = 1
endif

if g:plug.is_installed('vim-buftabline')
  hi BufTabLineCurrent ctermfg=220 ctermbg=242
  hi BufTabLineActive ctermfg=231 ctermbg=242
  hi BufTabLineHidden ctermfg=231 ctermbg=238
  hi BufTabLineFill ctermbg=237
endif

if g:plug.is_installed('lightline.vim')
  set laststatus=2

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
endif

noremap <C-t> <Nop> " for tmux

nnoremap <M-p> :call Openpr()<CR>
nnoremap <M-g> :Gbrowse master:%<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" buffer
nnoremap <S-k> :bn<CR>
nnoremap <S-j> :bp<CR>
nnoremap <S-x> :bw<CR>

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

" locad local rc
runtime! local.vim
