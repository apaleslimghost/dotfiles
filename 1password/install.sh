#!/usr/bin/env bash
set -e

echo '  ⎁ please log into 1password and enable CLI integration'
open -a '1password.app'

echo -n "  ⏎ press enter when you're done "
read -n1

op vault l
