#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/local/Cellar/git/*/etc/bash_completion.d/git-prompt.sh

# prompt
PS1="\[\033[34m\]strand:"
PS1+="\[\033[33m\]\w"
PS1+='\[\033[90m\]$(__git_ps1 " (%s)")'
PS1+="\[\033[31m\] ❯ \[\033[00m\]"
export PS1;

# aliases
alias ls='exa'
alias lst='exa -T'
alias lsg='exa -T --git-ignore'

alias vim='nvim'

alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias glo='git log --oneline'
alias gp='git push'

alias ytm='yt-dlp -x --audio-format m4a'

# Prevent cron from telling us we got mail
unset MAILCHECK

# colored manpages
export LESS_TERMCAP_mb=$'\e[01;32m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;4;31m'

export EDITOR='nvim'

[[ -n "$display" && "$term" = "screen" ]] && export term=screen-256color

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
