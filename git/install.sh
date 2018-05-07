#!/bin/bash

set -e

for f in git* ; do
    ln -snf $(pwd)/$f ~/.$f
done

if [ ! -f ~/.ssh/id_rsa ] ; then
    ssh-keygen -N "" -f ~/.ssh/id_rsa
fi

key_name="$USER.`hostname`"

if ! curl -s https://api.github.com/users/quarterto/keys | grep "$(cut -f2 -d' ' < ~/.ssh/id_rsa.pub)" > /dev/null ; then
   open "https://github.com/settings/tokens/new?scopes=write:public_key&description=$key_name+public+key"
   echo -n "Github OAuth token to add public key: "
   read -s github_token

   curl \
     -H "Authorization: token $github_token" \
     --data "{\"title\":\"$key_name\",\"key\":\"$(< ~/.ssh/id_rsa.pub)\"}" \
     https://api.github.com/user/keys
fi

# do some private framework magic to get wifi ssid
ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

if [ "$ssid" == 'FTWLAN1' ] ; then
   echo 'Copying public key and opening up Bitbucket'
   pbcopy < ~/.ssh/id_rsa.pub
   open http://git.svc.ft.com/plugins/servlet/ssh/account/keys/add
fi

git remote set-url origin git@github.com:quarterto/dotfiles.git
