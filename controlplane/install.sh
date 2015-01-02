#!/bin/sh
set -x -e
killall ControlPlane || echo "ControlPlane not running"
ln -sf "$(pwd)/com.dustinrue.ControlPlane.plist" ~/Library/Preferences/com.dustinrue.ControlPlane.plist
