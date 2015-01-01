#!/bin/bash

set -x -e

# install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew stuff
xargs brew tap < Tapfile
xargs brew install < Brewfile
xargs brew cask install < Caskfile

brew cask alfred link

# install npm stuff
xargs npm install -g < Npmfile

# link directories, run submodule-specific installation
for d in $(ls -d -- */); do
    if [ ! -f "$d"nolink ]; then
        ln -s "$(pwd)/$d" "~/.$d"
    fi

    if [ -f "$d"install.sh ]; then
        ./"$d"install.sh
    fi
done
