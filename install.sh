#!/bin/bash
set -x -e

link_and_install() {
    local d=$1
    if [ ! -f "$d"nolink ]; then
        ln -snf "$(pwd)/${d%/}" ~/".${d%/}"
    fi

    if [ -f "$d"install.sh ]; then
        pushd "$d"
        ./install.sh
        popd
    fi
}

# link directories, run submodule-specific installation
if [ $1 == "" ]; then
    for d in $(ls -d -- */); do
        link_and_install "$d"
    done
elif [ -d "$1" ]; then
    link_and_install "$1/"
fi
