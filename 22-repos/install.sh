#!/bin/sh

set -x -e

clone_all_the_things() {
	local repos=$(< $1)

	mkdir -p ~/Code

	for repo in $repos ; do
		gh repo clone $repo ~/Code/$repo || echo "Already cloned $repo"
	done
}

clone_all_the_things "${laptop_type:-personal}-repos"
