#!/bin/bash

digest_repos() {
	local root="$1"
	local file=$(basename $root)

	for repo in $(ls -t "$root" | head -20); do
		pushd "$root/$repo" > /dev/null
		git remote get-url origin
		popd > /dev/null
	done > $file
}

digest_repos ~/Work
