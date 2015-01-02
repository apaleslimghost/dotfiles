#!/bin/sh
set -x -e
if [ ! -f driver.zip ]; then
    wget ftp://ftp.saitek.com/pub/software/beta/Mac/Mad%20Catz%20RAT%20Driver%201.1.69.zip -O driver.zip
fi
if [ ! -f 'Mad Catz RAT Driver 1.1.69.pkg' ]; then
    unzip driver.zip
fi
sudo installer -pkg 'Mad Catz RAT Driver 1.1.69.pkg' -target /
cp Rat.pr0 ~/Library/Application\ Support/Smart\ Technology/RAT
