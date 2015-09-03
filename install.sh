#!/bin/sh
cd ~
mv ~/.bash_profile ~/.bash_profile.backup
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/latexmkrc ~/.latexmkrc
ln -s ~/dotfiles/hammerspoon ~/.hammerspoon
mv ~/.zshrc ~/.zshrc.backup
ln -s ~/dotfiles/oh-my-zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/ec /usr/local/bin/ec
git clone https://github.com/jinyangustc/prelude.git
ln -s ~/prelude/ ~/.emacs.d/
