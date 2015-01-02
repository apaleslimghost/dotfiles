#!/bin/bash
set -x -e
# install brew stuff
for t in $(<Tapfile); do
    brew tap $t
done
xargs brew install < Brewfile
xargs brew cask install < Caskfile
