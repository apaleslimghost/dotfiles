#!/usr/bin/env bash
set -euo pipefail

echo '  ⎁ some stuff for you to log into'

op read 'op://Private/Firefox Sync/password' | tr -d '\n' | pbcopy
echo '  ⎘ copied Firefox password to clipboard'
open -a 'Zen.app'

echo -n "  ⏎ press enter when you're done "
read -n1

op read 'op://Private/iTunes/password' | tr -d '\n' | pbcopy
echo '  ⎘ copied iCloud password to clipboard'
open /System/Library/PreferencePanes/AppleIDPrefPane.prefPane

echo -n "  ⏎ press enter when you're done "
read -n1
