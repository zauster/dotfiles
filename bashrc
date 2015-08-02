# ~/.bashrc: executed by bash(1) for non-login shells.


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTSIZE=15000
export HISTFILESIZE=15000
export HISTIGNORE="ls:ll:la:cls:cd:exit:pacupg"
# export SWEAVE_STYLEPATH_DEFAULT="TRUE"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac


# Load bash functions from a separate file:
if [ -f ~/.bash_func ]; then
    . ~/.bash_func
fi


# Load the bash prompt config, located in a separate file:
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi


# Alias definitions:
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
# fi
