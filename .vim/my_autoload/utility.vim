if g:plug.is_installed('denite.nvim')
  call denite#custom#var('grep', 'command', ['rg'])
	call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('file/rec', 'command', ['scantree.py', '--ignore="node_modules,.git,.idea,assets"'])

  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<M-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<M-k>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<TAB>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<S-TAB>', '<denite:move_to_previous_line>', 'noremap')

  call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
  call denite#custom#option('_', 'highlight_matched_range', 'None')
  call denite#custom#option('_', 'highlight_matched_char', 'Pmenu')
endif

if g:plug.is_installed('vim-auto-save')
  let g:auto_save = 1
  let g:auto_save_silent = 1
  let g:auto_save_events = ['InsertLeave', 'CursorHold']
  set updatetime=100
endif

if g:plug.is_installed('vim-tags')
  let g:vim_tags_ctags_binary = '/opt/brew/bin/ctags'
  let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} {DIRECTORY} 2>/dev/null"
  let g:vim_tags_gems_tags_command = "{CTAGS} -R {OPTIONS} `bundle show --paths` 2>/dev/null"
  let g:vim_tags_auto_generate = 1
  let g:vim_tags_ignore_files = ['.gitignore', $HOME.'/.gitignore_global']
endif

if g:plug.is_installed('vim-rooter')
  let g:rooter_use_lcd = 1
  let g:rooter_silent_chdir = 1
endif

if g:plug.is_installed('ale')
  autocmd BufRead * ALEDisable

  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop'],
  \}

  let g:ale_javascript_eslint_executable = 'eslint'
  let g:ale_javascript_eslint_use_global = 1

  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 0
  let g:ale_lint_on_text_changed = 0
endif
