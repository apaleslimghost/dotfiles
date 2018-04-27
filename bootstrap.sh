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

install_tools() {
    echo 'searching for update from app store'
    # install Command Line Tools, borrowed from
    # https://github.com/boxen/boxen-web/blob/2881bc53a66bfeb4f86a5850e888046d9d7ebf05/app/views/splash/script.sh.erb#L43
    # on 10.9 and above we can leverage SUS to get the latest CLI tools
    local TOOLS_REGEX="Command Line Tools"
    local PLACEHOLDER=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

    # create the placeholder file that's checked by CLI updates' .dist code
    # in Apple's SUS catalog
    touch $PLACEHOLDER

    # find the update with the right name, and grab its identifier
    PROD=$(softwareupdate -l | grep -B 1 "${TOOLS_REGEX}" | \
            awk -F"*" '/^ +\*/ {print $2}' | sed 's/^ *//' | head -n 1)

    # install it
    softwareupdate -i "${PROD}"

    # remove the placeholder
    rm -f $PLACEHOLDER
}

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
        install_tools 2>&1 | sed "s/^/  │ /"
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
