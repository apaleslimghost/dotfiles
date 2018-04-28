#!/bin/sh

dockutil --remove all --no-restart

dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '/Applications/Boxy.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Calendar.app' --no-restart
dockutil --add '/Applications/Notion.app' --no-restart
dockutil --add '/Applications/Atom.app' --no-restart
dockutil --add '/Applications/XCode.app' --no-restart
dockutil --add '/Applications/iTerm.app' --no-restart
dockutil --add '/Applications/Spotify.app' --no-restart
dockutil --add '/Applications/System Preferences.app' --no-restart

dockutil --add '' --type spacer --section apps
