#!/usr/bin/env bash
set -euo pipefail

git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom build
~/.emacs.d/bin/doom env
