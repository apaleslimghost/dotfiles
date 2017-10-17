#!/bin/sh

set -x -e

ln -snf "$(pwd)/RedPill v12Sierra.saver" "$HOME/Library/Screen Savers/RedPill v12Sierra.saver"

defaults write com.apple.screensaver modulePath -string "$HOME/Library/Screen Savers/RedPill v12Sierra.saver"
