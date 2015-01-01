#!/bin/bash

set -x -e

# install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew stuff
xargs brew tap < Tapfile
xargs brew install < Brewfile
xargs brew cask install < Caskfile

# install npm stuff
xargs npm install -g < Npmfile

# link directories, run submodule-specific installation
for d in $(ls -d -- */); do
    ln -s "$(pwd)/$d" "~/.$d"
    if [ -f "$d"install.sh ]; then
        ./"$d"install.sh
    fi
done
