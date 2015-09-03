#!/bin/sh
cd ~
rm ~/.bash_profile
mv ~/.bash_profile.backup ~/.bash_profile
rm ~/.latexmkrc
rm ~/.hammerspoon
rm ~/.zshrc
mv ~/.zshrc.backup ~/.zshrc
rm /usr/local/bin/ec
