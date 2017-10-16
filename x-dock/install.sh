#!/bin/sh

dockutil --remove all --no-restart

dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '/Applications/Airmail 3.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Calendar.app' --no-restart
dockutil --add '/Applications/Notion.app' --no-restart
dockutil --add '/Applications/Atom Beta.app' --no-restart
dockutil --add '/Applications/Hyper.app' --no-restart
dockutil --add '/Applications/Spotify.app' --no-restart
dockutil --add '/Applications/App Store.app' --no-restart
dockutil --add '/Applications/System Preferences.app' --no-restart

dockutil --add '' --type spacer --section apps
