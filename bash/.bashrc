#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
PS1="\[\033[34m\]strand:\[\033[00m\]"
PS1+="\[\033[33m\]\w"
PS1+="\[\033[31m\] ❯ \[\033[00m\]"
export PS1;

# aliases
alias ls='exa'
alias vi='nvim'
alias vim='nvim'
alias semver='git semver'
alias gitssh='eval `ssh-agent` && ssh-add ~/.ssh/srht.id_ed25519 && ssh-add ~/.ssh/github.id_ed25519'
alias youtube-dl='youtube-dl -x --audio-format m4a'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias glo='git log --oneline'
#alias ssh_ket='ssh -i "~/.ssh/ket-so-amazon-linux-2.pem" ec2-user@ec2-3-17-59-152.us-east-2.compute.amazonaws.com'

#scp_ket() {
    #scp -i "~/.ssh/ket-so-amazon-linux-2.pem" -r "$1" ec2-user@ec2-3-17-59-152.us-east-2.compute.amazonaws.com:$2/
#}

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
