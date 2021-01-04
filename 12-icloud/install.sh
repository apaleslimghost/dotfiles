#!/usr/bin/env bash
set -euo pipefail

icloud_root="~/Library/Mobile Documents/com~apple~CloudDocs/"

link_icloud_folder() {
	local from="$1"
	local to="$2"

	if [ -d "$to" ]; then
		sudo rm -rf "$to"
	fi

	ln -snf "$from" "$to"
}

link_icloud_folder "$icloud_root/Fonts" ~/Library/Fonts
link_icloud_folder "$icloud_root/Music" ~/Music
link_icloud_folder "$icloud_root/Projects" ~/Projects

