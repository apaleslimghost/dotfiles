#!/bin/sh

set -e



if ! command -v brew >/dev/null 2>&1 ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! brew cask ls | grep google-chrome ; then
   sudo rm -rf /Applications/Google\ Chrome.app
fi

if ! brew cask ls | grep slack ; then
   sudo rm -rf /Applications/Slack.app
fi

brew update
brew bundle
