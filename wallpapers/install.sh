#!/bin/sh

if [ -f "$1" ]; then
	file="$1"
else
	file="$(ls [0-9]* | tail -1)"
fi

setwp "$file"
