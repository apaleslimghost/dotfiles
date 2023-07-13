#!/usr/bin/env bash
set -e

if ! lpass status > /dev/null; then
	echo '  ⎁ please log in to last pass'
	lpass login --trust kara.brightwell@ft.com
fi

lpass show --password 'iTunes' | tr -d '\n' | pbcopy
echo '  ⎘ copied iTunes password to clipboard'

echo '  ⎁ please log in to the app store'
open -a 'App Store.app'

echo -n "  ⏎ press enter when you're done "
read -n1

brew bundle -v
