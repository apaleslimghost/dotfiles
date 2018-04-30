#!/bin/sh

set -x -e

clone_all_the_things() {
	local root="$HOME/$1"
	local repos=$(< $1)

	pushd $root

	for repo in $repos ; do
		git clone $repo
	done

	popd
}

# clone_all_the_things Projects
clone_all_the_things Work
