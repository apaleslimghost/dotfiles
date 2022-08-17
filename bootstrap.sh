#!/bin/bash

set -e

quit() {
    local code=$?
    if [ "0" -eq "$code" ] ; then
        echo ''
        echo '  ✌︎ goodbye'
        echo ''
    else
        echo ''
        echo '  ✗ something went wrong, sorry about that'
        echo ''
        exit $code
    fi
}

trap quit EXIT

update_repo() {
    git stash
    git checkout main
    git pull --rebase
}

run() {
    echo ''
    echo '  ☕︎ this might take a while'
    echo ''
    echo "  ✱ let's get sudo warmed up"
    sudo echo '  ✓ done'
    echo ''
    if [ ! -d '/Library/Developer/CommandLineTools' ] ; then
        echo '  ⚙︎ installing command line tools'
        sudo xcode-select --install

        while [ ! -d '/Library/Developer/CommandLineTools' ]; do
            echo '  ◷ still waiting for install'
            sleep 30
        done

        echo "  ✱ found command line tools, let's use them as our xcode"
        sudo xcode-select -s /Library/Developer/CommandLineTools/

        echo '  ✓ done'
        echo ''
    else
        echo '  ✓ command line tools already installed'
        echo ''
    fi

    if [ ! -d "$HOME/.Dotfiles" ] ; then
        echo '  ⎘ cloning dotfiles repo'
        # clone ourself
        git clone --recursive https://github.com/apaleslimghost/dotfiles.git ~/.Dotfiles 2>&1 | sed "s/^/  │ /"
        echo '  ✓ done'
        echo ''
    fi

    cd ~/.Dotfiles

    while [ "$laptop_type" != "work" ] && [ "$laptop_type" != "personal" ]; do
        echo -n '  ⎚ is this a work or personal laptop? '
        read laptop_type
        export $laptop_type
    done

    echo '  ◷ getting up to date'
    update_repo 2>&1 | sed "s/^/  │ /"
    echo '  ✓ done'
    echo ''
    echo '  ⎆ bootstrapped, moving to phase two'
    echo ''

    ./install.sh
}

run
