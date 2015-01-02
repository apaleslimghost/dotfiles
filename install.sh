#!/bin/bash
set -x -e

# link directories, run submodule-specific installation
for d in $(ls -d -- */); do
    if [ ! -f "$d"nolink ]; then
        ln -snf "$(pwd)/${d%/}" ~/".${d%/}"
    fi

    if [ -f "$d"install.sh ]; then
        pushd "$d"
        ./install.sh
        popd
    fi
done
