source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')
  "" Appearance
  Plug 'w0ng/vim-hybrid' " color scheme
  Plug 'itchyny/lightline.vim'  " upgrade status bar
  Plug 'cocopon/lightline-hybrid.vim' "status bar color scheme
  Plug 'Yggdroot/indentLine' " indent guide
  Plug 'bronson/vim-trailing-whitespace'  " highlight unused white space
  Plug 'ap/vim-buftabline' " make buffer visible like tabs

  "" NERDTree
  Plug 'scrooloose/nerdtree' " file tree
  Plug 'Xuyuanp/nerdtree-git-plugin' " add git status to nerdtree

  "" Utility
  Plug '907th/vim-auto-save' " auto save
  Plug 'tomtom/tcomment_vim'  " comment out
  Plug 'rhysd/accelerated-jk' " accelerate jk command
  Plug 'w0rp/ale' " syntax checker
  Plug 'tpope/tpope-vim-abolish' " better searcher
  Plug 'terryma/vim-expand-region' " expand visual mode selection
  Plug 'christoomey/vim-tmux-navigator' " tmux mover
  Plug 'airblade/vim-rooter' " auto change root of project
  Plug 'rizzatti/dash.vim' " dash plugin
  Plug 'Shougo/context_filetype.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'szw/vim-tags'
  Plug 'Shougo/deol.nvim'
  Plug 'timakro/vim-searchant'

  "" Text object
  Plug 'kana/vim-textobj-user'
  Plug 'osyo-manga/vim-textobj-multiblock'
  Plug 'tpope/vim-surround'

  "" Git
  Plug 'tpope/vim-fugitive' " git
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter' " show git diff

  "" Denite
  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/neomru.vim'
  Plug 'chemzqm/vim-easygit'
  Plug 'chemzqm/denite-git'
  Plug 'fishbullet/deoplete-ruby', { 'for': ['ruby'] }
  Plug 'uplus/deoplete-solargraph', { 'for': ['ruby'] }

  " Completion
  if has('nvim')
  	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

  " Ruby
  Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
  Plug 'alexgenco/neovim-ruby', { 'for': ['ruby'] }
  Plug 'tpope/vim-rails', { 'for': ['ruby'] }
  Plug 'AndrewRadev/switch.vim', { 'for': ['ruby'] }
  Plug 'tpope/vim-endwise', { 'for': ['ruby'] }
  Plug 'vim-scripts/ruby-matchit', { 'for': ['ruby'] }
  Plug '5t111111/denite-rails'
  Plug 'pocke/iro.vim', { 'for': ['ruby'] }
  Plug 'tpope/vim-haml'
  Plug 'fishbullet/deoplete-ruby', { 'for': ['ruby'] }
  Plug 'uplus/deoplete-solargraph', { 'for': ['ruby'] }

  " Javascript
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
  Plug 'leafgarland/typescript-vim'

  Plug 'google/vim-jsonnet'
  Plug 'elzr/vim-json'
call plug#end()

let g:plug = {
  \ "plugs": get(g:, 'plugs', {})
\ }

function! g:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction
