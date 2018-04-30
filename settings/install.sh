#!/bin/sh

echo '  │ setting screenshots folder'
defaults write com.apple.screencapture location $HOME/Documents/Screenshots
echo '  │ switching to dark mode'
dark-mode on
