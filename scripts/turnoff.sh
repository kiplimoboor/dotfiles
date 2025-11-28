#!/bin/bash

# Close all open windows
hyprctl clients -j | \
  jq -r ".[].address" | \
  xargs -I{} hyprctl dispatch closewindow address:{}

# Move to first workspace
hyprctl dispatch workspace 1 > /dev/null 2>&1

sleep 1 # Allow apps like Chrome to shutdown correctly

systemctl poweroff --no-wall
