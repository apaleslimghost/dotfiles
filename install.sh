#!/bin/bash
set -euo pipefail

link_and_install() {
    local d=${1%/}

    echo "  ⎙ setting up $d"

    if [ ! -f "$d"/nolink ]; then
        local target=".$d"
        if [ -f "$d"/linktarget ]; then
            target=$(< "$d"/linktarget)
        fi

        echo "  ⎌ linking folder to $target"

        mkdir -p ~/"$(dirname "$target")"
        ln -snf "$(pwd)/$d" ~/"$target"
    fi

    if [ -f "$d"/install.sh ]; then
        pushd "$d" > /dev/null
        ./install.sh
        popd > /dev/null
    fi

    echo '  ✓ done'
    echo ''
}

modules=$@

if [ "$1" == "" ]; then
    modules=$(ls -d -- */)
fi

for d in $modules; do
    link_and_install "$d"
done
