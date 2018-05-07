function cd
	emit precd
	builtin cd $argv
	emit postcd
end
