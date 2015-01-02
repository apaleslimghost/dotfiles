#!/bin/bash

set -e -x

fgrep -x -f <(brew ls | xargs brew deps --union | uniq) -v <(brew ls) # gets only top-level installs
brew tap > Tapfile
brew cask ls > Caskfile

npm ls -g --depth=0 2>/dev/null | cut -f 2 -d ' ' | cut -f 1 -d '@' | sed '1d' > Npmfile
