#!/bin/sh

set -e

if ! grep pam_tid /etc/pam.d/sudo; then
	echo '  │ adding touch id support to sudo'

	sudo sed -e '2i\
auth       sufficient     pam_tid.so' -i.bak /etc/pam.d/sudo
fi
