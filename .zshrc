######################################################################
### misc
######################################################################
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

autoload -Uz colors
colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

setopt auto_pushd
setopt pushd_ignore_dups
setopt ignore_eof
setopt no_beep
setopt nonomatch
setopt print_eight_bit


######################################################################
### path
######################################################################
export EDITOR=nvim
export LC_ALL='en_US.UTF-8'
export GOPATH=$HOME/.go
export TERM=xterm-256color
export GHQ_ROOT=$HOME/ghq
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"
export PATH=$GOPATH/bin:$PATH
export PATH=/opt/brew/bin:$PATH

typeset -U path PATH


######################################################################
### plugins
######################################################################
ZPLUG_HOME=~/.zsh/zplug

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/anyframe"

zplug load --verbose 1>/dev/null 2>&1


######################################################################
### alias
######################################################################
alias ls='ls -G'
alias tmux='tmux -2'
alias gs='git status --short'
alias ts='tig status'
alias vim='nvim'
alias ctags="`brew --prefix`/bin/ctags"
alias mvim='open -a MacVim "$@"'
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-t'


######################################################################
### tools
######################################################################
# hub
eval "$(hub alias -s)"

# anyenv
eval "$(anyenv lazyload)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"


######################################################################
### functions
######################################################################
function git-hash(){
  local current_buffer=$BUFFER
  local selected="$(git log --oneline --branches | peco | awk '{print $1}')"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N git-hash

function git-stash(){
  local current_buffer=$BUFFER
  local selected="$(git stash list | peco | awk '{print $1}' | sed -e 's/://g')"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N git-stash

function git-changed(){
  local current_buffer=$BUFFER
  local selected="$(git status --short | peco | awk '{print $2}')"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N git-changed

function ghq-cd () {
  local selected=$(find $GHQ_ROOT -maxdepth 3 -mindepth 3 | sed -e "s#$GHQ_ROOT/##g" | peco --query "$LBUFFER")
  if [ -n "$selected" ]; then
    BUFFER="cd $GHQ_ROOT/$selected"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-cd

function file-search(){
  local current_buffer=$BUFFER
  local selected="$(find . -maxdepth 10 | peco)"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N file-search

function peco-select-tmux-session(){
  if [ -n "$TMUX" ]; then
     local SELECTED="$(tmux list-sessions | peco | cut -d : -f 1)"
     tmux switch-client -t $SELECTED
     return 0
   fi
}
zle -N peco-select-tmux-session


######################################################################
### keybind
######################################################################
bindkey -e

# anyframe
bindkey '^xr' anyframe-widget-put-history
bindkey '^xb' anyframe-widget-checkout-git-branch
bindkey '^xe' anyframe-widget-insert-git-branch

bindkey '^xw' git-changed
bindkey '^xc' git-hash
bindkey '^xl' git-stash
bindkey '^xg' ghq-cd
bindkey '^xf' file-search
bindkey '^xs' peco-select-tmux-session


######################################################################
### tmux
######################################################################
if [[ ! -n $TMUX ]]; then
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  ID="`echo $ID | peco | cut -d: -f1`"
  tmux attach-session -t "$ID"
fi

autoload -Uz add-zsh-hook
function rename_tmux_window() {
  if [[ -n $TMUX ]]; then
    local current_path=`pwd | sed -e s/\ /_/g`
    local current_dir=`basename $current_path`
    tmux rename-window $current_dir
  fi
}
add-zsh-hook precmd rename_tmux_window


######################################################################
### prompt
######################################################################
local cdir='%(?.%F{green}.%F{yellow})%n%f at %F{cyan}%m%f in %F{blue}%~%f'
local success='(～・ω ・)～'
local fail='< ∩ ´﹏` ∩ >'

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green} +%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red} !%f'
zstyle ':vcs_info:*' formats ' on %F{yellow}%b%c%u%f'
zstyle ':vcs_info:*' actionformats ' on %F{red}%b|%a%f'
precmd () { vcs_info }

PROMPT='%B
${cdir}${vcs_info_msg_0_} %F{238}[%*]%f
%(?.%F{green}.%F{yellow})%(?.${success}.${fail})%f $ %b'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
