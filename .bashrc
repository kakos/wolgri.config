# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

eval `dircolors -b ~/.dircolors`

shopt -s cdspell
shopt -s extglob
shopt -s cmdhist
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -u promptvars
set -o noclobber
#kill flow control
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

complete -cf sudo         # sudo tab-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# ADDONS 
if [ -f ~/bash/aliases ]; then
    . ~/bash/aliases
fi

if [ -f ~/bash/function ]; then
    . ~/bash/function
fi

if [ -f ~/bash/exports ]; then
    . ~/bash/exports
fi

if [ -f ~/bash/myprompt ]; then
    . ~/bash/myprompt
fi 


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
