# |------------------------------------------|
# | This file is autogenerated. Do not edit! |
# |------------------------------------------|
# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Main {{{

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion

  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# }}}

# Source {{{
. "$HOME/.local/kitty.app/lib/kitty/shell-integration/bash/kitty.bash"
. "$HOME/.bash_completions/please.sh"
. "$HOME/.cargo/env"

# Functions
. ~/.bash_funcs

# Aliases
. ~/.bash_aliases
# }}}

# Variables {{{
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set history length.
HISTFILESIZE=2000
HISTSIZE=1000

# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export EDITOR="nvim -u ~/.config/nvim/vi_init.lua --noplugins"
export VISUAL="nvim -u ~/.config/nvim/vim_init.lua"
export SUDO_EDITOR="$EDITOR"
# }}}

# Prompt {{{
# Set chroot variable for prompt
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Exit status
exstat ()
{
    ret=$?

    if [[ $ret != 0 ]]; then
        printf "[$ret] "
    fi
}

if [[ $(tty) = *tty* ]]; then
    PS1='\[\e[38;2;218;112;214m\]$(exstat)\[\e[38;2;148;0;211m\]\[\e[97;48;2;148;0;211m\] $(spwd) \[\e[0;38;2;148;0;211m\] \[\e[38;2;131;111;255m\]\u@\l \[\e[38;2;224;102;255m\]\$ \[\e[0m\]'
else
    PS1='\[\e[38;2;218;112;214m\]$(exstat)\[\e[38;2;148;0;211m\]\[\e[97;48;2;148;0;211m\] $(spwd) \[\e[0;38;2;148;0;211m\] \[\e[38;2;131;111;255m\]\u\[\e[38;2;224;102;255m\]\$ \[\e[0m\]'
fi

# Old prompts
# PS1='\[\e[30;48;5;81;1m\] $(spwd) \[\e[0;38;5;81;48;5;86m\]\[\e[30;1m\] \u \[\e[0;38;5;86;48;5;140m\]\[\e[30;1m\] \$ \[\e[0;38;5;140m\] \[\e[0m\]'
# PS1='\[\e[30;48;5;81;1m\] $(spwd) \[\e[0;38;5;81;48;5;86m\]\[\e[30;1m\] \u \[\e[0;38;5;86;48;5;140m\]\[\e[30;1m\] \$ \[\e[0;38;5;140m\] \[\e[0m\]'
# }}}

# Config {{{
shopt -s checkwinsize
shopt -s histappend
shopt -s globstar
shopt -s cdspell
shopt -s autocd
set -o vi
# }}}

if [[ $(tty) = *tty* ]]; then
    echo "tty detected, no annoying messages"
    return
fi

# Choose screen layout {{{
if [ ! -f /tmp/screen_layout_chosen ]; then
    input='n'
    read -p "Choose a screen layout to apply:
1. Top.sh
2. Other.sh
: " input

    case "$input" in
        *'1'*) ~/.screenlayout/top.sh
        ;;
        *'2'*) ~/.screenlayout/other.sh
        ;;
    esac

    touch /tmp/screen_layout_chosen
    unset input
fi
# }}}

# ssh agent. {{{
env=~/.ssh/agent.env

agent_load_env () {
    test -f "$env" && . "$env" >| /dev/null ;
}

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ;
}
agent_load_env

# agent_run_state: 0 agent running w/ key; 1 agent w/o key; 2 agent not running.
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add

elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi
# }}}

# To-do {{{
important_count=$(grep -icE 'study|homework|important' ~/.config/please/config.json)
done_count=$(grep -ic '"done": true' ~/.config/please/config.json)
term_count=$(ls /dev/pts/ | grep -vcE '[[:alpha:]]')

if (( $done_count >= 2 )) ; then
    please clean
else
    please
fi

## Read the to-do list warning {{{
if (( $important_count >= 1 )); then
    red='\033[0;31m'
    nc='\033[0m'

    if (( $important_count > 3)); then
        echo -e "${red}" \
        '
 _  ______ _____  ___ ______   _____ _   _  _____   _____ _____       ______ _____   _     _____ _____ _____   _ 
| | | ___ \  ___|/ _ \|  _  \ |_   _| | | ||  ___| |_   _|  _  |      |  _  \  _  | | |   |_   _/  ___|_   _| | |
| | | |_/ / |__ / /_\ \ | | |   | | | |_| || |__     | | | | | |______| | | | | | | | |     | | \ `--.  | |   | |
| | |    /|  __||  _  | | | |   | | |  _  ||  __|    | | | | | |______| | | | | | | | |     | |  `--. \ | |   | |
|_| | |\ \| |___| | | | |/ /    | | | | | || |___    | | \ \_/ /      | |/ /\ \_/ / | |_____| |_/\__/ / | |   |_|
(_) \_| \_\____/\_| |_/___/     \_/ \_| |_/\____/    \_/  \___/       |___/  \___/  \_____/\___/\____/  \_/   (_)
        ' \
        "${nc}"
        sleep 3
    else
        echo -e "${red} ! READ THE TO-DO LIST ! ${nc}"
        sleep 2
    fi
    unset nc red
fi
## }}}

## Other to-dos {{{
if (( $term_count <= 2 )); then
    input='n'
    read -p "Do you wish to see other stuff to-do? (y/n): " input

    if [[ $input = [yY]* ]] ; then
        cd ~/notes/to_dos/

        glow
        cd - > /dev/null
    fi

    unset input
fi
## }}}

unset term_count important_count done_count
# }}}

# Emilly S.H. :D

