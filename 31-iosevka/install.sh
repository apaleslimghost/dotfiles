#!/usr/bin/env bash
set -euo pipefail

cp -fv *.ttf ~/Library/Fonts | column -t | sed "s/^/  │ /"
