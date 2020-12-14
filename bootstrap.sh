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
    git checkout master
    git pull --rebase
    git submodule update --recursive --remote
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
        echo '  ✓ done'
        echo ''
    else
        echo '  ✓ command line tools already installed'
        echo ''
    fi

    if ! xcode-select --print-path | grep Xcode.app > /dev/null; then
        echo '  ⎌ setting xcode location'
        sudo xcode-select -s /Library/Developer/CommandLineTools/
        echo '  ✓ done'
        echo ''
    fi

    if [ ! -d "$HOME/.Dotfiles" ] ; then
        echo '  ⎘ cloning dotfiles repo'
        # clone ourself
        git clone --recursive git://github.com/quarterto/dotfiles ~/.Dotfiles 2>&1 | sed "s/^/  │ /"
        echo '  ✓ done'
        echo ''
    fi

    cd ~/.Dotfiles

    echo '  ◷ getting up to date'
    update_repo 2>&1 | sed "s/^/  │ /"
    echo '  ✓ done'
    echo ''
    echo '  ⎆ bootstrapped, moving to phase two'
    echo ''

    ./install.sh
}

run
