. ~/.bashrc

# Homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Golang
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Completions
[ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
    . $(brew --prefix)/etc/bash_completion.d/git-completion.bash

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
