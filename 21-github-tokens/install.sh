#/bin/sh

set -e

ask_for_token() {
	local token_name="$1"
	if ! security find-generic-password -a $USER -s "$token_name" -w 2>&1 > /dev/null ; then
		open "https://github.com/settings/tokens/new?scopes=read:org&description=$(echo "$token_name" | tr ' ' '+')+`hostname`"
		echo -n "Github OAuth token for $token_name: "
		read -s token

		security add-generic-password -a "$USER" -s "$token_name" -w "$token"

		echo "Added $token_name token to Keychain"
	fi
}

if [ "$laptop_type" == "work" ]; then
	ask_for_token "FT Vault"
fi
