#!/bin/bash

set -e

digest_repos() {
	local root="$1"
	local file=$(basename $root)

	for repo in $(ls -t "$root" | head -20); do
		pushd "$root/$repo" > /dev/null
		echo "  → " $repo 1>&2
		git remote get-url origin
		popd > /dev/null
	done > $file
}

digest_repos ~/Work
digest_repos ~/Projects
