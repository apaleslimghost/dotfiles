#/bin/sh

echo -n "Github OAuth token to auth with Vault: "
read -s vault_token

security add-generic-password -a "$USER" -s "FT Vault" -w "$vault_token"

echo "Added token to Keychain"

export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a $USER -s "FT Vault" -w)
export VAULT_ADDR="https://vault.in.ft.com"

vault auth --method github
