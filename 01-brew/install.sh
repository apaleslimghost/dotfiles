#!/bin/sh

set -e

if ! command -v brew >/dev/null 2>&1 && [ ! -d /opt/homebrew ] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -d /opt/homebrew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

brew update
brew bundle -v --file=Brewfile-${laptop_type:-personal}
