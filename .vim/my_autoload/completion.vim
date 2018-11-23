if g:plug.is_installed('deoplete.nvim')
  " set completeopt+=noinsert

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_complete_start_length = 2
  let g:deoplete#auto_complete_delay = 0
  inoremap <expr><C-c> pumvisible() ? deoplete#close_popup(): "\<C-c>"
  set completeopt-=preview
  let g:deoplete#tag#cache_limit_size = 5000000

  let g:deoplete#sources#ternjs#tern_bin = '/opt/brew/bin/tern'
  let g:deoplete#sources#ternjs#timeout = 1
  let g:deoplete#sources#ternjs#filetypes = [
  \ 'js',
  \ 'jsx',
  \ ]
endif

if g:plug.is_installed('javascript-libraries-syntax.vim')
  let b:javascript_lib_use_react = 1

  let g:used_javascript_libs = 'jquery, react'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_react = 1
endif
