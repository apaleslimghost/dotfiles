#!/bin/sh

installed_packages() {
	apm ls -i -b | cut -d @ -f 1
}

installed_packages > Atomfile
