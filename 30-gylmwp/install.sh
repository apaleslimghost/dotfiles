#!/bin/sh
set -e

if [ ! -d "$HOME/Library/Keyboard Layouts" ]; then
	cp -fR Gylmwp.bundle "$HOME/Library/Keyboard Layouts"
	sudo cp -fR Gylmwp.bundle "/Library/Keyboard Layouts"
	echo '  ‼ log in and back out before switching to it kthx'
fi
