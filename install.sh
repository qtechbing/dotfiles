#!/bin/sh
cd ~
ln -s ~/dotfiles/latexmkrc ~/.latexmkrc
ln -s ~/dotfiles/hammerspoon ~/.hammerspoon
mv ~/.zshrc ~/.zshrc.backup
ln -s ~/dotfiles/oh-my-zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/ec /usr/local/bin/ec
