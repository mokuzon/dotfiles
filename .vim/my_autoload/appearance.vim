syntax on
set synmaxcol=300

set ruler
set colorcolumn=80,128

if g:plug.is_installed('vim-hybrid')
  let g:hybrid_custom_term_colors = 1
  colorscheme hybrid
endif


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
hi Pmenu ctermfg=white ctermbg=8
hi PmenuSel ctermfg=32 ctermbg=220
hi SearchCurrent ctermfg=255 ctermbg=32

let g:vim_json_syntax_conceal = 0

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

if g:plug.is_installed('vim-jsx-pretty')
  let g:vim_jsx_pretty_enable_jsx_highlight = 1
  let g:vim_jsx_pretty_colorful_config = 1
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
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
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
      return "\uE0A2"
    else
      return ""
    endif
  endfunction

  function! LightLineFugitive()
    if exists("*fugitive#head")
      let branch = fugitive#head()
      return branch !=# '' ? "\uE0A0 " .branch : ''
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
