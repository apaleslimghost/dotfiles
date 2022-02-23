#!/bin/sh

set -e

if ! command -v brew >/dev/null 2>&1 ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -d /opt/homebrew ]; then
  source $(/opt/homebrew/bin/brew shellenv)
fi

brew update
brew bundle
