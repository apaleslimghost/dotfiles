#/bin/sh

exit 0

if ! security find-generic-password -a $USER -s "FT Vault" -w 2>&1 > /dev/null ; then
	open "https://github.com/settings/tokens/new?scopes=read.org&description=Vault+`hostname`"
	echo -n "Github OAuth token to auth with Vault: "
	read -s vault_token

	security add-generic-password -a "$USER" -s "FT Vault" -w "$vault_token"

	echo "Added token to Keychain"
fi

export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a $USER -s "FT Vault" -w)
export VAULT_ADDR="https://vault.in.ft.com

# do some private framework magic to get wifi ssid
ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

if [ "$ssid" == 'FTWLAN1' ] ; then
	vault auth --method github
fi
