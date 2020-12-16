#!/usr/bin/env bash
set -e

if ! mas account; then
	echo '  ⎁ please log in to the app store'
	open -a 'App Store.app'

	while ! mas account; do
		echo '  ◷ still waiting for app store'
		sleep 30
	done
fi

brew bundle
