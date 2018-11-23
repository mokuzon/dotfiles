## prompt
autoload colors
colors
# left prompt
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
