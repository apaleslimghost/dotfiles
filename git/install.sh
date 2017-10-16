#!/bin/bash

set -e

for f in git* ; do
    cp $f ~/.$f
done