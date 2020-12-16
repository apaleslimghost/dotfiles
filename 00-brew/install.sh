#!/bin/sh

set -e

if ! command -v brew >/dev/null 2>&1 ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# remove FT-provided Slack.app
if [ ! -d /usr/local/Caskroom/slack ] ; then
   sudo rm -rf /Applications/Slack.app
fi

brew update
brew bundle
