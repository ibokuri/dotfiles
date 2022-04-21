if [[ $- == *i* && -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# Golang
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Zig
export PATH=$PATH:/usr/local/bin/zig

# Rust
source "$HOME/.cargo/env"
