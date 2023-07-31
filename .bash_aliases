# This file is autogenerated. Do not edit!
# ~/.bash_aliases

# App aliases.
alias apt_up='sudo apt update && sudo apt upgrade -y && notify-send -u normal "Updates & upgrades finished."'
alias vim='nvim -u ~/.config/nvim/vim_init.lua'
alias vi='vim'

alias icat="kitty +kitten icat --hold"
alias yt-mp4='yt-dlp -f mp4 -o'

alias python='python3'
alias xdelta='xdelta3'

# ls aliases.
alias li='ls -lh -I "$(cat .ignore 2> /dev/null)" -I "$(cat .gitignore 2> /dev/null)"'
alias la='ls -lha'
alias l='ls -lh'

# Script aliases.
alias start_ssh='~/dev/scripts/ssh_start.sh'
alias weather='~/dev/scripts/weather.sh'

# Other aliases.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cale='cal | grep --color -EC6 "\b$(date +%e | sed "s/ //g")"'
alias fix-bg='feh --bg-scale --randomize ~/media/wallpapers/*'

alias where='whereis'
alias rm='rm -i'

alias c='clear'
alias x='exit'
