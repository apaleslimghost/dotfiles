#!/bin/bash

set -x -e

# install Homebrew
brew info || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

./brew.sh 
echo "Press enter when you've set up Alfred's preferences"
open -b com.runningwithcrayons.Alfred-Preferences
read

brew cask alfred link
brew linkapps

# install npm stuff
npm install -g npm@latest
xargs npm install -g < Npmfile

./install.sh
