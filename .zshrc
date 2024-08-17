# linux only too
# stty -ixon
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/go"
export VOLTA_HOME="$HOME/.volta"

ZSH_THEME="nicoulaj"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# make sure you change the normal nvim installation location
export PATH="$PATH:/opt/nvim/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.zig"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
# this isnt standard, id recommend installing here tho
export PATH="$PATH:/usr/local/zig"

# OPTIONAL - flutter and android-studio for android dev
# export PATH="$PATH:$HOME/Documents/android-studio/bin"
# export PATH="$PATH:/usr/bin/flutter/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

