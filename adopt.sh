#!/usr/bin/env bash
set -euo pipefail

adopt() {
	local target="$1"
	local real_target="$(realpath "$target")"
	local parent="$(dirname "$real_target")"
	local name=$(basename $real_target)

	if [ -d ~/.Dotfiles/"${name#.}" ]; then
		echo "  ⤼ skipping $target, already adopted?"
		return
	fi

	if [[ "$parent" != "$HOME" ]]; then
		echo "${real_target#$HOME/}" > "$real_target/linktarget"
	fi

	mv "$real_target" ~/.Dotfiles/"${name#.}"
	echo "  ⤓ adopted $name"
	./install.sh "${name#.}"
}

adopt_all() {
	for target in $@; do
		adopt "$target"
	done
}

adopt_all $@
