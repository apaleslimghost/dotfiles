function vault
	command vault $argv
	echo 'all' | history delete --prefix 'vault write' > /dev/null
end
