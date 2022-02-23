#!/bin/sh

set -e

eject() {
	local d=${1%/}
	local target=".$d"

	if [ -f "$d"/linktarget ]; then
		target="$(< "$d"/linktarget)"
	fi

	rm ~/"$target"
	mv "$(pwd)/$d" ~/"$target"
}

eject "$1"
