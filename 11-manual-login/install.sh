#!/usr/bin/env bash
set -euo pipefail

echo '  ⎁ some stuff for you to log into'

open -a 'Firefox.app'
open /System/Library/PreferencePanes/AppleIDPrefPane.prefPane

echo -n "  ⏎ press enter when you're done "
read -n1
