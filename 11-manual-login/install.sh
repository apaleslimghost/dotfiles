#!/usr/bin/env bash
set -euo pipefail

echo '  ⎁ some stuff for you to log into'

if ! lpass status > /dev/null; then
   echo '  ⎁ please log in to last pass'
   lpass login --trust kara.brightwell@ft.com
fi

lpass show --password 'Firefox Sync' | tr -d '\n' | pbcopy
echo '  ⎘ copied Firefox password to clipboard'
open -a 'Firefox.app'

echo -n "  ⏎ press enter when you're done "
read -n1

lpass show --password 'iTunes' | tr -d '\n' | pbcopy
echo '  ⎘ copied iCloud password to clipboard'
open /System/Library/PreferencePanes/AppleIDPrefPane.prefPane

echo -n "  ⏎ press enter when you're done "
read -n1
