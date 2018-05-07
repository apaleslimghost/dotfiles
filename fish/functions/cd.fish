function cd
	emit precd $argv
	builtin cd $argv
	emit postcd $argv
end
