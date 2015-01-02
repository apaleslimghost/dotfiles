#!/bin/sh
set -x -e
killall Alfred\ 2 || echo "Alfred not running"
killall Alfred\ Preferences || echo "Alfred Prefs not running"
cp -f alfredhat.png ~/Applications/Alfred\ 2.app/Contents/Frameworks/Alfred\ Framework.framework/Resources/alfredhat.png
open elementary-dark.alfredappearance
