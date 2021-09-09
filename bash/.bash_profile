# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin/zig:$PATH"
export PATH="/usr/local/bin/zls:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# If .bash_profile exists, bash doesn't read .profile
if [[ -f ~/.profile ]]; then
    . ~/.profile
fi

# If the shell is interactive and .bashrc exists, get aliases and functions
if [[ $- == *i* && -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

export CLICOLOR=1
export TERM=xterm-256color

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Disable zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1
