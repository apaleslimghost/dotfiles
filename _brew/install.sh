#!/bin/sh

set -e

if ! command -v brew >/dev/null 2>&1 ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -d /usr/local/Caskroom/google-chrome ] ; then
   sudo rm -rf /Applications/Google\ Chrome.app
fi

if [ ! -d /usr/local/Caskroom/slack ] ; then
   sudo rm -rf /Applications/Slack.app
fi

brew update
brew bundle
