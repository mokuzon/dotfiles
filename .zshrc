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
export FZF_DEFAULT_OPTS='--reverse'
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
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
zplug "zsh-users/zsh-completions"

zplug load --verbose 1>/dev/null 2>&1
zstyle ":anyframe:selector:" use fzf


######################################################################
### alias
######################################################################
alias ls='exa'
alias cat='bat'
alias find='fd'
alias ps='procs'
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
function git-changed(){
  local current_buffer=$BUFFER
  local selected="$(git status --short | awk '{print $2}' | fzf --preview "bat --style=numbers --color=always --line-range :500 {}")"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N git-changed

function file-search(){
  local current_buffer=$BUFFER
  local selected="$(fd . --type f -d 10 | fzf --preview "bat --style=numbers --color=always --line-range :500 {}")"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N file-search


######################################################################
### keybind
######################################################################
bindkey -e

# anyframe
bindkey '^xr' anyframe-widget-put-history
bindkey '^xb' anyframe-widget-checkout-git-branch
bindkey '^xe' anyframe-widget-insert-git-branch
bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^xf' file-search
bindkey '^xw' git-changed


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
