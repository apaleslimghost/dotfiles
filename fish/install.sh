#!/bin/sh

if ! grep fish /etc/shells > /dev/null ; then
    which fish | sudo tee -a /etc/shells
fi

chsh -s $(which fish) 