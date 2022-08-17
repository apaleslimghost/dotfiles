#!/bin/bash

set -e

digest_repos() {
	local file="$1"

	for repo in $(ls -t "$root" | head -20); do
		pushd "$root/$repo" > /dev/null
		echo "  → " $repo 1>&2
		git remote get-url origin
		popd > /dev/null
	done > $file
}

digest_repos "${laptop_type:-personal}-repos"
