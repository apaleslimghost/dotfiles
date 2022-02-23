#!/usr/bin/env bash
set -e

if ! mas account; then

	if ! lpass status > /dev/null; then
		echo '  ⎁ please log in to last pass'
		lpass login --trust kara.brightwell@ft.com
	fi

	lpass show --password 'iTunes' | pbcopy
	echo '  ⎘ copied iTunes password to clipboard'

	echo '  ⎁ please log in to the app store'
	open -a 'App Store.app'

	while ! mas account; do
		echo '  ◷ still waiting for app store'
		sleep 30
	done
fi

brew bundle -v
