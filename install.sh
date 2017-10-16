#!/bin/bash
set -e

link_and_install() {
    local d=$1

    echo "  ⎙ setting up $d"

    if [ ! -f "$d"nolink ]; then
        echo '  ⎌ linking folder'
        ln -snf "$(pwd)/${d%/}" ~/".${d%/}"
    fi

    if [ -f "$d"install.sh ]; then
        pushd "$d" > /dev/null
        ./install.sh
        popd > /dev/null
    fi

    echo '  ✓ done'
    echo ''
}

# link directories, run submodule-specific installation
if [ "$1" == "" ]; then
    for d in $(ls -d -- */); do
        link_and_install "$d"
    done
elif [ -d "$1" ]; then
    link_and_install "$1/"
fi
