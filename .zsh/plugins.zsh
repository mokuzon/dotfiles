export ZPLUG_HOME=~/.zsh/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "chrissicool/zsh-256color"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-autosuggestions"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"

zplug "supercrabtree/k"

zplug "mollifier/anyframe"
bindkey '^xr' anyframe-widget-put-history
bindkey '^xb' anyframe-widget-checkout-git-branch
bindkey '^xp' anyframe-widget-cdr
bindkey '^xg' anyframe-widget-cd-ghq-repository

zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

zplug "hamano/ame.sh", as:command, use:ame.sh

# Then, source plugins and add commands to $PATH
zplug load --verbose 1>/dev/null 2>&1
