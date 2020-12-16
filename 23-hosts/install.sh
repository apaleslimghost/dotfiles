#!/bin/sh

if ! grep local.ft.com /etc/hosts > /dev/null ; then
	echo '127.0.0.1 local.ft.com' | sudo tee -a /etc/hosts
fi
