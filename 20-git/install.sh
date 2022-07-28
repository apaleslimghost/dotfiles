#!/bin/bash

set -e

for f in git* ; do
    ln -snf $(pwd)/$f ~/.$f
done

if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -N "" -f ~/.ssh/id_rsa
fi

key_name="$USER.`hostname`"

if ! curl -s https://api.github.com/users/apaleslimghost/keys | grep "$(cut -f2 -d' ' < ~/.ssh/id_rsa.pub)" > /dev/null ; then
   open "https://github.com/settings/tokens/new?scopes=write:public_key&description=$key_name+public+key"
   echo -n "Github OAuth token to add public key: "
   read -s github_token

   curl \
     -H "Authorization: token $github_token" \
     --data "{\"title\":\"$key_name\",\"key\":\"$(< ~/.ssh/id_rsa.pub)\"}" \
     https://api.github.com/user/keys
fi

open https://github.com/settings/keys
echo -n "  ⏎ go authorise the key with SAML pls "
read -n1

git remote set-url origin git@github.com:apaleslimghost/dotfiles.git
