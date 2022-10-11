znap_path=~/.Dotfiles/zsh/plugins/znap

source $znap_path/znap.zsh

znap eval homebrew "$(/opt/homebrew/bin/brew shellenv)"
znap eval ohmyposh 'oh-my-posh init zsh --print --config=https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin.omp.json'
znap prompt

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

export VOLTA_HOME=$HOME/.volta
path=($VOLTA_HOME/bin $path)
export PATH
