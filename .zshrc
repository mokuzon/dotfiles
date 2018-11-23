export EDITOR=nvim

bindkey -e

# completion
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1  # select by Tag
autoload predict-on

# load devided setting files
ZSH_HOME=~/.zsh

for f in $ZSH_HOME/*.zsh
do
  source "$f"
done

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_expand

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
setopt pushd_ignore_dups
# auto cd
setopt AUTO_CD

# show Japanese
setopt print_eight_bit

# no beep
setopt no_beep

# off ctrl-D
setopt ignore_eof

# for vim
KEYTIMEOUT=1

export PATH=$PATH:./node_modules/.bin
powerline-daemon -q

typeset -U path PATH
