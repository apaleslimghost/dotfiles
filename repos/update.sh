#!/bin/bash

> non-repos
> errors

digest_repos() {
	local root="$1"
	local outfile="$(pwd)/$root"
	local errors="$(pwd)/errors"
	local nonrepos="$(pwd)/non-repos"

	> "$outfile"

	for f in ~/"$root"/*; do
		if [ -d "$f/.git" ]; then
			pushd "$f" > /dev/null

			if ! git remote get-url origin >> "$outfile" 2>> "$errors" ; then
				echo $f >> "$errors"
			fi

			popd > /dev/null
		else
			echo $f >> $nonrepos
		fi
	done
}

# digest_repos Projects
digest_repos Work
