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
nnoremap <M-c> :echo expand('%:p')<CR>
nnoremap <M-p> :call Openpr()<CR>
nnoremap <M-g> :Gbrowse<CR>
nnoremap <M-t> :Deol<CR>
nnoremap <M-s> :ALEToggle<CR>
nnoremap <M-y> viw"*y
nnoremap <M-d> :Dash<CR>
" nnoremap <M-n> :NERDTreeToggle \| wincmd p<CR>
nnoremap <M-n> :NERDTreeToggle<CR>
nnoremap <C-M-n> :NERDTreeFind<CR>
nnoremap <C-M-t> :TagbarToggle<CR>

" tags
nnoremap <silent> tb :TagbarToggle<CR>
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

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
vmap j gj
vmap k gk

let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)

vnoremap y "*y
nnoremap yy "*yy
nnoremap P "*p

inoremap <silent> jj <ESC>

nnoremap N Nzz
nnoremap n nzz

omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

vmap v <Plug>(expand_region_expand)
vmap <S-v> <Plug>(expand_region_shrink)

nnoremap <silent> db :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
nnoremap <silent> dc :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
nnoremap <silent> dg :<C-u>Denite grep -highlight-mode-insert=Search<CR>
nnoremap <silent> dl :<C-u>Denite line -highlight-mode-insert=Search<CR>
nnoremap <silent> dm :<C-u>Denite file_mru -highlight-mode-insert=Search<CR>
nnoremap <silent> drm :<C-u>Denite rails:model -highlight-mode-insert=Search<CR>
nnoremap <silent> drc :<C-u>Denite rails:controller -highlight-mode-insert=Search<CR>
nnoremap <silent> drv :<C-u>Denite rails:view -highlight-mode-insert=Search<CR>
nnoremap <silent> drh :<C-u>Denite rails:helper -highlight-mode-insert=Search<CR>
nnoremap <silent> drs :<C-u>Denite rails:spec -highlight-mode-insert=Search<CR>
nnoremap <silent> dgs :<C-u>Denite gitstatus -highlight-mode-insert=Search<CR>
nnoremap <silent> dgc :<C-u>Denite gitchanged -highlight-mode-insert=Search<CR>
nnoremap <silent> dgl :<C-u>Denite gitlog -highlight-mode-insert=Search<CR>
nnoremap <silent> dgla :<C-u>Denite gitlog:all -highlight-mode-insert=Search<CR>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-M-/> :TmuxNavigatePrevious<cr>
