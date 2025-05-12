#!/bin/bash

set -e

for f in git* ; do
    ln -snf $(pwd)/$f ~/.$f
done

if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -N "" -f ~/.ssh/id_rsa
fi

if ! gh auth status >/dev/null 2>&1 ; then
    echo '  ⚿ logging in to gh'
    gh auth login -s admin:public_key -s admin:ssh_signing_key
fi

if ! gh ssh-key list | grep $(hostname) >/dev/null 2>&1 ; then
    echo '  ⚿ adding SSH key to Github account'
    gh ssh-key add ~/.ssh/id_rsa.pub
fi

git remote set-url origin git@github.com:apaleslimghost/dotfiles.git
