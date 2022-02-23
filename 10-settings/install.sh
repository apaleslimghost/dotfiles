#!/bin/sh

set -e

echo '  │ switching to dark mode'
dark-mode on

echo '  │ send screenshots to clipboard'
defaults write com.apple.screencapture target clipboard
echo '  │ telling finder to show things'
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo '  │ telling finder to snap to grid'
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo '  │ setting dock size'
defaults write com.apple.dock tilesize -int 48
echo '  │ turning dock autohide on'
defaults write com.apple.dock autohide -bool true

echo '  │ killing finder and dock'
killall Finder Dock
