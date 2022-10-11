#!/bin/bash

set -e

znap_path=~/.Dotfiles/zsh/plugins/znap

if ! [[ -f $znap_path/znap.zsh ]]; then
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $znap_path
fi

for f in .z* ; do
    ln -snf $(pwd)/$f ~/$f
done

set -x

if ! grep /opt/homebrew/bin/zsh /etc/shells > /dev/null ; then
	echo /opt/homebrew/bin/zsh | sudo tee -a /etc/shells
fi

chsh -s /opt/homebrew/bin/zsh
