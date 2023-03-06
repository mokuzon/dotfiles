lan en_US.UTF-8
set backupdir=~/.vim/tmp
set belloff=all
set hidden
set mouse=a
set modifiable
set noswapfile
set autoread
set foldmethod=indent
set foldlevel=100
set clipboard=unnamedplus

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
  call dein#add('neoclide/coc-tabnine', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-html', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('neoclide/coc-css', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('felippepuhle/coc-graphql', { 'build': 'yarn install --frozen-lockfile' })
  call dein#add('antoinemadec/coc-fzf', { 'build': 'yarn install --frozen-lockfile' })

  " " Utility
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('907th/vim-auto-save') " auto save
  call dein#add('tomtom/tcomment_vim')  " comment out
  call dein#add('preservim/nerdtree')
  call dein#add('vim-test/vim-test')
  call dein#add('tpope/vim-dispatch')
  call dein#add('jparise/vim-graphql')
  call dein#add('github/copilot.vim')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/open-browser-github.vim')

  " Ruby
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-endwise')

  " Jsonnet
  call dein#add('google/vim-jsonnet')

  " terraform
  call dein#add('hashivim/vim-terraform')

  call dein#end()
  call dein#save_state()
endif

nmap <silent> <C-]> <Plug>(coc-definition)

let $FZF_DEFAULT_OPTS='--extended --layout=reverse --cycle'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ['InsertLeave', 'CursorHold']
set updatetime=100

" let g:openbrowser_github_always_used_branch = system("git remote show origin | grep 'HEAD branch' | awk '{print $NF}'")
let g:openbrowser_github_always_used_branch = 'main'

let g:extra_whitespace_ignored_filetypes = ['diff', 'gitcommit', 'qf', 'help']

"" filetypes
au BufNewFile,BufRead *.iam set filetype=ruby
au FileType json syntax match Comment +\/\/.\+$+ " allow comment syntax for json

let g:test#strategy = 'dispatch'
let g:dispatch_compilers = {
  \ 'bundle exec': 'rake',
  \ }
let g:test#ruby#rspec#options = '--require ~/.vim/rspec_quickfix_formatter.rb --format QuickfixFormatter 2>/dev/null'

"" NERDTree
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

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

function! LaunchNERDTree()
  if index(['gitrebase'], &filetype) != -1
    return
  endif

  NERDTree
  wincmd p
  call SyncTree()
endfunction

function! CloseBufferOrVim()
  if &filetype == 'qf'
    cclose
  elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) >= 2
    bprev
    bdelete #
  else
    qa
  endif
endfunction

autocmd VimEnter * call LaunchNERDTree()
autocmd BufEnter * call SyncTree()

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
hi CocMenuSel ctermfg=15 ctermbg=25
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

"" keymaps
noremap <C-t> <Nop> " for tmux

inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "<Down>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "<Up>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "<Enter>"
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "<End>"

noremap <silent> fb :Buffers<CR>
noremap <silent> ff :Files<CR>
noremap <silent> fg :GFiles?<CR>
noremap <silent> fh :History<CR>
noremap <silent> fr :Rg <C-R><C-W><CR>

nnoremap <M-n> :NERDTreeToggle<CR>
nnoremap <M-p> :call Openpr()<CR>
nnoremap <M-g> :OpenGithubFile<CR>
vnoremap <M-g> :OpenGithubFile<CR>

vnoremap dl :!translate-to-english-by-deepl<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" buffer
nnoremap <S-k> :bn<CR>
nnoremap <S-j> :bp<CR>
nnoremap <S-x> :call CloseBufferOrVim()<CR>

inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

noremap <C-p> <Up>
noremap <C-n> <Down>
noremap <C-b> <Left>
noremap <C-f> <Right>
noremap <C-a> <home>
noremap <C-e> <End>
noremap <C-d> <Del>

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
source ~/.vim/local.vim
