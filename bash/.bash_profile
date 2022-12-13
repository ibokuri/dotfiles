. ~/.bashrc

# Zig
export PATH=$PATH:$HOME/.zvm/bin

# Golang
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Rust
source "$HOME/.cargo/env"

# Completions
source /usr/local/etc/bash_completion.d/git-completion.bash
export PATH="/usr/local/sbin:$PATH"
