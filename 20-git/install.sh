#!/bin/bash

set -e

for f in git* ; do
    ln -snf $(pwd)/$f ~/.$f
done

if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -N "" -f ~/.ssh/id_rsa
fi

if ! gh auth status >/dev/null 2>&1
    gh auth login
fi

git remote set-url origin git@github.com:apaleslimghost/dotfiles.git
