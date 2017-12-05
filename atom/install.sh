#!/bin/bash

apm='apm'

if command -v apm-beta > /dev/null ; then
	apm='apm-beta'
fi

installed_packages() {
	$apm ls -i -b | cut -d @ -f 1
}

not_installed=$(comm -23 Atomfile <(installed_packages))
installed_but_shouldnt_be=$(comm -23 <(installed_packages) Atomfile)

if [ "$not_installed" != "" ] ; then
	$apm install $not_installed
else
	echo "No Atom packages to install"
fi


if [ "$installed_but_shouldnt_be" != "" ] ; then
	$apm remove $installed_but_shouldnt_be
else
	echo "No Atom packages to remove"
fi
