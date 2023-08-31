znap_path=~/.Dotfiles/zsh/plugins

source $znap_path/znap/znap.zsh

zstyle ':znap:*' repos-dir $znap_path

znap eval homebrew "/opt/homebrew/bin/brew shellenv"
znap eval ohmyposh 'oh-my-posh init zsh --print --config=https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin.omp.json'
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
znap eval rbenv 'rbenv init - zsh'
znap prompt

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey -M menuselect '\r' .accept-line

zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

() {
   local -a prefix=( '\e'{\[,O} )
   local -a up=( ${^prefix}A ) down=( ${^prefix}B )
   local key=
   for key in $up[@]; do
      bindkey "$key" up-line-or-history
   done
   for key in $down[@]; do
      bindkey "$key" down-line-or-history
   done
}

export VAULT_ADDR="https://vault.in.ft.com"
export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Vault" -w)

export VOLTA_HOME=$HOME/.volta
path=($VOLTA_HOME/bin ~/.iterm2 $path)
export PATH
