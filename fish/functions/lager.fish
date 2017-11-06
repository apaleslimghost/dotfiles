function lager
	pushd ~/.Dotfiles
	sed '/\# end '$argv[1]'/a '$argv[1]' "'$argv[2]'"' _brew/Brewfile
end
