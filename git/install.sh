#!/bin/bash

set -e

for f in git* ; do
    cp $f ~/.$f
done

if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -N "" -f ~/.ssh/id_rsa
fi

key_name="$USER.`hostname`"

open 'https://github.com/settings/tokens/new?scopes=write:public_key&description=dotfiles+public+key'
echo -n "Github OAuth token to add public key (leave blank to skip): "
read -s github_token

if [ "" != "$github_token" ] ; then
    curl \
        -H "Authorization: token $github_token" \
        --data "{\"title\":\"$key_name\",\"key\":\"$(< ~/.ssh/id_rsa.pub)\"}" \
        https://api.github.com/user/keys
fi