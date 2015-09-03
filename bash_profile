
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by Anaconda3 2.2.0 installer
export PATH="$HOME/anaconda/bin:$PATH"
export PATH="/usr/texbin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/CrossPack-avr"
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
