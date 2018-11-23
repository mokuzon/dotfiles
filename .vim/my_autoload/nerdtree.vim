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

  fun! MyNERDTreeToggle()
    if exists('NERDTree')
      NERDTreeToggle
    else
      NERDTreeFind
      wincmd p
    endif
  endfun

  fun! MyNERDTreeFocus()
    if glob(expand("%")) == '' || !&modifiable
      return
    endif
    NERDTreeFind
    wincmd p
  endfun

  fun! CloseBuffer() abort
    let l:fname = expand('%')
    bp
    execute 'bw '.l:fname
  endfun
endif
