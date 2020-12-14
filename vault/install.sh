#/bin/sh

exit 0

if ! security find-generic-password -a $USER -s "FT Vault" -w 2>&1 > /dev/null ; then
	open "https://github.com/settings/tokens/new?scopes=read.org&description=Vault+`hostname`"
	echo -n "Github OAuth token to auth with Vault: "
	read -s vault_token

	security add-generic-password -a "$USER" -s "FT Vault" -w "$vault_token"

	echo "Added token to Keychain"
fi
