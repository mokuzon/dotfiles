" auto reload
set autoread
augroup checktime
  au!
  "silent! necessary otherwise throws errors when using command
  "line window.
  autocmd BufEnter        * silent! checktime
  autocmd CursorHold      * silent! checktime
  autocmd CursorHoldI     * silent! checktime
  "these two _may_ slow things down. Remove if they do.
  autocmd CursorMoved     * silent! checktime
  autocmd CursorMovedI    * silent! checktime
augroup END

" GitHub
function! Openpr() abort
  let line = line('.')
  let fname = expand('%')
  let cmd = printf('git blame -L %d,%d %s | cut -d " " -f 1', line, line, fname)
  let sha1 = system(cmd)
  let cmd = printf('git openpr %s', sha1)
  echo system(cmd)
endfunction
