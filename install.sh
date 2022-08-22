#!/bin/bash
set -eo pipefail

link_and_install() {
    local d=${1%/}

    echo "  ⎙ setting up $d"

    if [ ! -f "$d"/nolink ]; then
        local target=".$d"
        if [ -f "$d"/linktarget ]; then
            target="$(< "$d"/linktarget)"
        fi

        echo "  ⎌ linking folder to $target"

        if [ -d "$target" ]; then
            echo "  ! $target already exists!"
            return 1
        fi

        mkdir -p ~/"$(dirname "$target")"
        ln -snf "$(pwd)/$d" ~/"$target"
    fi

    if [ -f "$d"/install.sh ]; then
        pushd "$d" > /dev/null
        source install.sh
        popd > /dev/null
    fi

    echo '  ✓ done'
    echo ''
}

modules=$@

work_modules="00-sudo
01-brew
02-app-store
11-manual-login
gh
20-git
21-github-tokens
22-repos
23-hosts
30-gylmwp
focus
karabiner
nushell"

personal_modules="$work_modules
ableton
kicad
minecraft"

if [ "$1" == "" ]; then
    while [ "$laptop_type" != "work" ] && [ "$laptop_type" != "personal" ]; do
        echo -n '  ⎚ is this a work or personal laptop? '
        read laptop_type
        export $laptop_type
    done

    case $laptop_type in
    work)
        modules=$work_modules ;;
    personal)
        modules=$personal_modules ;;
    *)
        modules=$(ls -d -- */) ;;
    esac
fi

for d in $modules; do
    link_and_install "$d"
done
