#!/bin/bash

set -x -e

# install Homebrew
brew info || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew stuff
xargs brew tap < Tapfile
xargs brew install < Brewfile
xargs brew cask install < Caskfile

open -W -b com.runningwithcrayons.Alfred-Preferences

brew cask alfred link
brew linkapps

# install npm stuff
npm install -g npm@latest
xargs npm install -g < Npmfile

./install.sh
