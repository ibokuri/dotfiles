#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
source /usr/local/Cellar/git/*/etc/bash_completion.d/git-prompt.sh

PS1="\[\033[34m\]strand:"
PS1+="\[\033[33m\]\w"
PS1+='\[\033[90m\]$(__git_ps1 " (%s)")'
PS1+="\[\033[31m\] ❯ \[\033[00m\]"
export PS1;

# aliases
alias vim='nvim'

alias ls='exa'
alias lst='exa -T'
alias lsg='exa -T --git-ignore'

alias ga='git add'
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

# environment variables
export EDITOR='nvim'

# Prevent cron from telling us we got mail
unset MAILCHECK

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
