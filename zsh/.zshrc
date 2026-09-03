znap_path=$HOME/.Dotfiles/zsh/plugins

source $znap_path/znap/znap.zsh

zstyle ':znap:*' repos-dir $znap_path

znap eval homebrew "/opt/homebrew/bin/brew shellenv"
znap eval ohmyposh 'oh-my-posh init zsh --eval --config=https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin.omp.json'
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
znap eval rbenv 'rbenv init - zsh'
znap prompt

znap source zdharma-continuum/fast-syntax-highlighting

source "$HOME/.local/share/inshellisense/init/zsh/init.zsh"

setopt -o sharehistory

export VOLTA_HOME=$HOME/.volta
path=($VOLTA_HOME/bin ~/.iterm2 $HOME/.local/bin $HOME/bin $path $HOME/.cargo/bin)
export PATH

if which doppler > /dev/null; then
	export DOPPLER_TOKEN=$(doppler configure get token --plain)
fi

export CLOUDSMITH_AUTH_TOKEN=$(security find-generic-password -a $USER -s "Cloudsmith Personal API key" -w 2>/dev/null)

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
