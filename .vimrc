"" General
" bin
let g:python_host_prog = $HOME.'/.anyenv/envs/pyenv/versions/2.7.18/bin/python'
let g:python3_host_prog = $HOME.'/.anyenv/envs/pyenv/versions/3.8.2/bin/python'
let g:node_host_prog = $HOME.'/.anyenv/envs/nodenv/versions/12.16.3/bin/neovim-node-host'

lan en_US.UTF-8
set backupdir=~/.vim/tmp
set belloff=all " no beep
set hidden " move to another file before saving
set mouse=a " enable mouse support
set modifiable " enable window resize
set noswapfile
set ttimeoutlen=10 " avoid mode change lag

" iskeyword
set iskeyword-=.
set iskeyword+=-
set iskeyword+=@-@
set iskeyword+=?

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

" for CoC & Git
set signcolumn=auto:2

set lazyredraw
set ttyfast

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

  " NERDTree
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] } " file tree
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] } " add git status to nerdtree

  " CoC
  Plug 'neoclide/coc.nvim', { 'do': './install.sh nightly' }
  Plug 'neoclide/coc-solargraph', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }

  " Utility
  Plug '907th/vim-auto-save' " auto save
  Plug 'tomtom/tcomment_vim'  " comment out
  Plug 'airblade/vim-rooter' " auto change root of project
  Plug 'timakro/vim-searchant'
  Plug 'majutsushi/tagbar'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'

  " Denite
  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/neomru.vim'
  Plug 'chemzqm/denite-git'

  " Ruby
  Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
  Plug 'tpope/vim-rbenv', { 'for': ['ruby'] }
  Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
  Plug 'tpope/vim-rails', { 'for': ['ruby'] }
  Plug 'tpope/vim-endwise', { 'for': ['ruby'] }
  Plug 'vim-scripts/ruby-matchit', { 'for': ['ruby'] }
  Plug '5t111111/denite-rails', { 'for': ['ruby'] }
  Plug 'tpope/vim-haml'
  Plug 'slim-template/vim-slim'

  " TypeScript
  Plug 'leafgarland/typescript-vim'

  " Javascript
  Plug 'mxw/vim-jsx'

  " JSON
  Plug 'elzr/vim-json', { 'for': ['json'] }
  Plug 'google/vim-jsonnet'

  " Terraform
  Plug 'fatih/vim-hclfmt'
call plug#end()

let g:plug = {
  \ "plugs": get(g:, 'plugs', {})
\ }

function! g:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

if g:plug.is_installed('denite.nvim')
  let s:denite_win_width_percent = 0.85
  let s:denite_win_height_percent = 0.7

  call denite#custom#option('default', {
  \ 'split': 'floating',
  \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
  \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
  \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
  \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
  \ })

  call denite#custom#option('default', { 'start_filter': 'true' })
  call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', '--glob', '!node_modules'])
  call denite#custom#var('grep', 'command', ['rg'])
	call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])

  autocmd FileType denite-filter call s:denite_filter_my_settings()
	function! s:denite_filter_my_settings() abort
    inoremap <silent><buffer><expr> <C-[> denite#do_map('quit')
    inoremap <silent><buffer><expr> jj denite#do_map('quit')
    inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	  inoremap <silent><buffer> <C-n> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	  inoremap <silent><buffer> <C-p> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
	  inoremap <silent><buffer> <C-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	  inoremap <silent><buffer> <C-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
	endfunction

  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    call denite#do_map('open_filter_buffer')

    nnoremap <silent><buffer><expr> <C-[> denite#do_map('quit')
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  endfunction

  function! g:GetVisualWord() abort
    let word = getline("'<")[getpos("'<")[2] - 1:getpos("'>")[2] - 1]
    return word
  endfunction
endif

if g:plug.is_installed('nerdtree')
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

  fun! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
  endfun

  fun! MyNERDTreeToggle()
    if IsNERDTreeOpen()
      NERDTreeClose
    elseif strlen(expand('%')) > 0
      NERDTreeFind
      wincmd p
    else
      NERDTreeToggle
      wincmd p
    endif
  endfun
  autocmd VimEnter * call MyNERDTreeToggle()

  fun! MyNERDTreeFocus()
    if IsNERDTreeOpen()
      if index(['help', 'nerdtree', 'tagbar', 'denite', 'denite-filter'], &ft) <= 0
        NERDTreeFind
        wincmd p
      endif
    endif
  endfun

  autocmd BufWinEnter * call MyNERDTreeFocus()
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

if g:plug.is_installed('vim-auto-save')
  let g:auto_save = 1
  let g:auto_save_silent = 1
  let g:auto_save_events = ['InsertLeave', 'CursorHold']
  set updatetime=100
endif

if g:plug.is_installed('vim-rooter')
  let g:rooter_use_lcd = 1
  let g:rooter_silent_chdir = 1
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
  let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'startify', 'tagbar']
  let g:indentLine_faster = 1
endif

if g:plug.is_installed('vim-buftabline')
  hi BufTabLineCurrent ctermfg=220 ctermbg=242
  hi BufTabLineActive ctermfg=231 ctermbg=242
  hi BufTabLineHidden ctermfg=231 ctermbg=238
  hi BufTabLineFill ctermbg=237
end

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
let g:vim_json_syntax_conceal = 0


"" scripts
fun! CloseBuffer() abort
  let l:fname = expand('%')
  bp
  execute 'bw '.l:fname

  if (winnr("$") == 1 && IsNERDTreeOpen())
    qa
  endif
endfun

set autoread
augroup checktime
  au!
  autocmd BufEnter        * silent! checktime
  autocmd CursorHold      * silent! checktime
  autocmd CursorHoldI     * silent! checktime
augroup END


"" keybind
if &diff
  cnoremap q qa
endif

noremap <C-t> <Nop> " for tmux

noremap  <silent> <C-j> <C-w>w
inoremap <silent> <C-j> <Esc><C-w>w
tnoremap <silent> <C-j> <C-\><C-n><C-w>w
noremap  <silent> <C-k> <C-w>W
inoremap <silent> <C-k> <Esc><C-w>W
tnoremap <silent> <C-k> <C-\><C-n><C-w>W
tnoremap <silent> <ESC> <C-\><C-n>

nnoremap <M-r> :<C-u>setlocal cursorline! cursorcolumn!<CR>
nnoremap <M-t> :TagbarToggle<CR>
nnoremap <M-n> :call MyNERDTreeToggle()<CR>
nnoremap <M-c> :echo expand('%:p')<CR>
nnoremap <M-p> :call Openpr()<CR>
nnoremap <M-g> :Gbrowse master:%<CR>
nnoremap <M-y> viw"*y
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" tags
nnoremap <C-]> :exe("tjump ".expand('<cword>'))<CR>
nnoremap tv :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap th :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" buffer
nnoremap <S-k> :bn<CR>
nnoremap <S-j> :bp<CR>
nnoremap <S-x> :call CloseBuffer()<CR>

inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

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

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

vnoremap y "*y
nnoremap yy "*yy
nnoremap P "*p

inoremap <silent> jj <ESC>

nnoremap <silent> db :<C-u>Denite buffer<CR>
nnoremap <silent> df :<C-u>Denite file/rec<CR>
nnoremap <silent> dg :<C-u>Denite grep<CR>
nmap <silent> dgw viwdg
nnoremap <silent> dl :<C-u>Denite line<CR>
nnoremap <silent> dm :<C-u>Denite file_mru<CR>
nnoremap <silent> drm :<C-u>Denite rails:model<CR>
nnoremap <silent> drc :<C-u>Denite rails:controller<CR>
nnoremap <silent> drv :<C-u>Denite rails:view<CR>
nnoremap <silent> drh :<C-u>Denite rails:helper<CR>
nnoremap <silent> drs :<C-u>Denite rails:spec<CR>
nnoremap <silent> dgs :<C-u>Denite gitstatus<CR>
nnoremap <silent> dgc :<C-u>Denite gitchanged<CR>
nnoremap <silent> dgl :<C-u>Denite gitlog<CR>
nnoremap <silent> dgla :<C-u>Denite gitlog:all<CR>

vnoremap <silent> dg :<C-u>Denite grep:::`GetVisualWord()`<CR>

" locad local rc
runtime! local.vim
