setenv NVM_DIR "$HOME/.nvm"

function nvm
    bass source /usr/local/opt/nvm/nvm.sh ';' nvm $argv
end