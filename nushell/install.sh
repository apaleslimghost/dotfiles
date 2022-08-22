#!/bin/bash

set -x

if ! grep /opt/homebrew/bin/nu /etc/shells > /dev/null ; then
	echo /opt/homebrew/bin/nu | sudo tee -a /etc/shells
fi

chsh -s /opt/homebrew/bin/nu
