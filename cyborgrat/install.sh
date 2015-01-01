#!/bin/sh

wget ftp://ftp.saitek.com/pub/software/beta/Mac/Mad%20Catz%20RAT%20Driver%201.1.69.zip -O driver.zip
unzip driver.zip
sudo installer -pkg 'Mad Catz RAT Driver 1.1.69.pkg' -target /
