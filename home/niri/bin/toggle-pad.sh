#!/bin/sh

WORKSPACE=$(niri msg --json workspaces | jq -r "first(.[] | select(.is_focused == true))")

[ -z "$WORKSPACE" ] && return

OUTPUT=$(echo "$WORKSPACE" | jq -r ".output")
WORKSPACE_ID=$(echo "$WORKSPACE" | jq ".id")

SESSION="niri-pad"
APP_ID="$SESSION-$OUTPUT"

WINDOW=$(niri msg --json windows | jq "first(.[] | select(.app_id == \"$APP_ID\"))")
WINDOW_ID=$(echo "$WINDOW" | jq ".id")
WINDOW_WS=$(echo "$WINDOW" | jq ".workspace_id")

if [ -z "$WINDOW" ]; then
  alacritty --class="$APP_ID" -e zellij attach "$SESSION" -c
elif [ "$WINDOW_WS" = "$WORKSPACE_ID" ]; then
  niri msg action close-window --id "$WINDOW_ID"
else
  niri msg action move-window-to-workspace "$WORKSPACE_ID" --window-id "$WINDOW_ID"
  niri msg action focus-window --id "$WINDOW_ID"
fi
