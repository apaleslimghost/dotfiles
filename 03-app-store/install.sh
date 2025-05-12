#!/usr/bin/env bash
set -e

op read op://Private/iTunes/password | tr -d '\n' | pbcopy
echo '  ⎘ copied iTunes password to clipboard'

echo '  ⎁ please log in to the app store'
open -a 'App Store.app'

echo -n "  ⏎ press enter when you're done "
read -n1

brew bundle -v
