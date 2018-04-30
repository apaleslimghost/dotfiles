#!/bin/sh

if ! grep fish /etc/shells > /dev/null ; then
    which fish | sudo tee -a /etc/shells
fi

user_shell="$(finger $USER | grep Shell | cut -f6 -d ' ')"

if [ "$user_shell" != "$(which fish)" ]; then
   chsh -s $(which fish) 
fi
