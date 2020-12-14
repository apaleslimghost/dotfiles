#!/bin/sh

dockutil --remove all --no-restart

dockutil --add '/Applications/Firefox.app' --no-restart
dockutil --add '/Applications/Emacs.app' --no-restart
dockutil --add '/Applications/Jira.app' --no-restart
dockutil --add '/Applications/Slack.app' --no-restart
dockutil --add '/Applications/Discord.app' --no-restart
dockutil --add '/Applications/Spotify.app' --no-restart
dockutil --add '/Applications/Music.app' --no-restart
dockutil --add '/Applications/Calendar.app' --no-restart
dockutil --add '/Applications/Notion.app' --no-restart
dockutil --add '/Applications/Bear.app' --no-restart
dockutil --add '/Applications/System Preferences.app'

