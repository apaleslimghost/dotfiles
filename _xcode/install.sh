#!/bin/sh

mas install 497799835 # that's Xcode

sudo xcode-select -s /Applications/XCode.app/Contents/Developer
sudo xcodebuild -licence accept

brew bundle
