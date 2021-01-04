#!/usr/bin/env bash
set -euo pipefail

icloud_root="~/Library/Mobile Documents/com~apple~CloudDocs/"

ln -snf "$icloud_root/Fonts" ~/Library/Fonts
ln -snf "$icloud_root/Music" ~/Music

