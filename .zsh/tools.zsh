## cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

## peco
function peco-find-file() {
  local current_buffer=$BUFFER
  if git rev-parse 2> /dev/null; then
      source_files=$(git ls-files)
  else
      source_files=$(find . -type f)
  fi
  local selected=$(echo $source_files | peco)
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N peco-find-file
bindkey '^xf' peco-find-file

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
bindkey '^xc' git-hash

function git-branch(){
  local current_buffer=$BUFFER
  local selected="$(git branch | sed -e 's/* /  /g' | peco | awk '{print $1}')"
  if [ -n "$selected" ]; then
    BUFFER="${current_buffer}${selected}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N git-branch
bindkey '^xe' git-branch

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
bindkey '^xl' git-stash

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
bindkey '^xw' git-changed

function peco-select-tmux-session()
{
  local session="$(tmux list-sessions | peco | cut -d : -f 1)"
  if [ -n "$session" ]; then
    if [ -n "$TMUX" ]; then
      BUFFER="tmux switch-client -t $session"
    else
      BUFFER="tmux a -t $session"
    fi
    zle accept-line
  fi
}
zle -N peco-select-tmux-session
bindkey '^xs' peco-select-tmux-session

function tmux-new-session()
{
  tmux new-session -s $(basename $(pwd))
}

function rgvim () {
  vim $(rg $@ | peco --query "$LBUFFER" | awk -F : '{print $1}')
}


## direnv
eval "$(direnv hook zsh)"

## ndenv
eval "$(ndenv init -)"

## hub
eval "$(hub alias -s)"

## anyenv
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

## tmux
# powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

## neovim
export XDG_CONFIG_HOME=$HOME/.config

## go
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

## less
export LESS='-gMR'
