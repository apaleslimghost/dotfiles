#!/usr/bin/env bash
set -euo pipefail

ln -sf /usr/local/opt/emacs-plus@28/Emacs.app /Applications

if [ ! -d ~/.emacs.d ]; then
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
else
	~/.emacs.d/bin/doom update
fi

~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom build
