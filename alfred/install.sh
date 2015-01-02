#!/bin/sh
set -x -e
killall Alfred\ 2
killall Alfred\ Preferences
cp -f alfredhat.png ~/Applications/Alfred\ 2.app/Contents/Frameworks/Alfred\ Framework.framework/Resources/alfredhat.png
open elementary-dark.alfredappearance
