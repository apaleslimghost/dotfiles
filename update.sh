#!/bin/bash

set -e -x

brew ls > Brewfile
brew tap > Tapfile
brew cask ls > Caskfile

npm ls -g --depth=0 2>/dev/null | cut -f 2 -d ' ' | cut -f 1 -d '@' | sed '1d' > Npmfile
