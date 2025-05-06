#!/usr/bin/env bash

# Basics
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------

# System bashrc
test -r /etc/bash.bashrc && . /etc/bash.bashrc

# Notify bg task completion immediately
set -o notify

# Disable mail notifications
unset MAILCHECK

# Default umask
umask 0022

#-------------------------------------------------------------------------------
# Env. Configuration
#-------------------------------------------------------------------------------

# Detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# Detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# Locale
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# XDG config. This is different on Mac for historical reasons, but on our Linux
# dev machines we can keep it clean. Its important anything we do that uses the
# XDG directories uses the exported env vars directly.
case $UNAME in
    Linux*)
        export XDG_CONFIG_HOME="$HOME/.config"
        ;;
    *)
        export XDG_CONFIG_HOME="$HOME/.config"
        ;;
esac

# Silence deprecation on Catalina
export BASH_SILENCE_DEPRECATION_WARNING=1

#-------------------------------------------------------------------------------
# Editor and Pager
#-------------------------------------------------------------------------------

export EDITOR='nvim'

export PAGER="less -FirSwX"
export MANPAGER="$PAGER"

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------

source /opt/homebrew/Cellar/git/*/etc/bash_completion.d/git-prompt.sh

PS1="\[\033[34m\]strand:"
PS1+="\[\033[33m\]\w"
PS1+='\[\033[90m\]$(__git_ps1 " (%s)")'
PS1+="\[\033[31m\] ❯ \[\033[00m\]"
export PS1;

#-------------------------------------------------------------------------------
# Project Directories
#-------------------------------------------------------------------------------

export PERSONAL_PROJECTS_DIR="$HOME/Projects/Personal"
export FOREIGN_PROJECTS_DIR="$HOME/Projects/Foreign"

#-------------------------------------------------------------------------------
# Aliases / Functions
#-------------------------------------------------------------------------------

# Vim
alias vim='nvim'

# Eza
alias ls='eza'
alias lst='eza -T'
alias lsg='eza -T --git-ignore'

# Git
alias ga='git add'
alias gb='git branch'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git commit -m'
alias gcv='git commit -v'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias glo='git log --oneline'
alias gp='git push'
alias gpf='git push --force-with-lease'

# Project
alias cdp="cd $PERSONAL_PROJECTS_DIR"
alias cdf="cd $FOREIGN_PROJECTS_DIR"

# Youtube (2)
alias ytm="yt-dlp -x --audio-format m4a --audio-quality 0"
alias ytm3="yt-dlp -x --audio-format mp3 --audio-quality 0"

#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------

SSH_ENV=$HOME/.ssh/environment

function start_ssh_agent {
    if [ ! -x "$(command -v ssh-agent)" ]; then
        return
    fi

    if [ ! -d "$(dirname $SSH_ENV)" ]; then
        mkdir -p $(dirname $SSH_ENV)
        chmod 0700 $(dirname $SSH_ENV)
    fi

    ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 0600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    ssh-add
}

# Source SSH agent settings if it is already running, otherwise start up the
# agent proprely.
if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     # ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_ssh_agent
     }
else
    case $UNAME in
      MINGW*)
        ;;
      *)
        start_ssh_agent
        ;;
    esac
fi

#-------------------------------------------------------------------------------
# FZF
#-------------------------------------------------------------------------------

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#-------------------------------------------------------------------------------
# RVM
#-------------------------------------------------------------------------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#-------------------------------------------------------------------------------
# Rust
#-------------------------------------------------------------------------------

. "$HOME/.cargo/env"
