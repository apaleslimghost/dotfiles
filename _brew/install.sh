#!/bin/sh

set -e

sudo rm -rf /Applications/Google\ Chrome.app /Applications/Slack.app

if ! command -v brew >/dev/null 2>&1 ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew bundle
