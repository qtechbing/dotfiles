#!/bin/sh
cd ~
rm ~/.latexmkrc
rm ~/.hammerspoon
rm ~/.zshrc
mv ~/.zshrc.backup ~/.zshrc
rm /usr/local/bin/ec
