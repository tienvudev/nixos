#!/bin/sh

WORKSPACE="$(niri msg --json workspaces | jq "first(.[] | select(.is_focused == true))")"
[ -z "$WORKSPACE" ] && return

OUTPUT="$(echo "$WORKSPACE" | jq -r ".output")"
[ -z "$OUTPUT" ] && return

WORKSPACE_ID="$(echo "$WORKSPACE" | jq ".id")"
WORKSPACE_IDX="$(echo "$WORKSPACE" | jq ".idx")"

SESSION="niri.pad"
APP_ID="$SESSION.$OUTPUT"

WINDOW="$(niri msg --json windows | jq "first(.[] | select(.app_id == \"$APP_ID\"))")"
WINDOW_ID="$(echo "$WINDOW" | jq ".id")"
WINDOW_WS="$(echo "$WINDOW" | jq ".workspace_id")"

move-pad() {
  niri msg action move-window-to-workspace --window-id "$WINDOW_ID" --focus false "$@"
}

if [ -z "$WINDOW" ]; then
  ghostty --class="$APP_ID"
elif [ "$WINDOW_WS" = "$WORKSPACE_ID" ]; then
  move-pad 99
else
  move-pad "$WORKSPACE_IDX"
  niri msg action focus-window --id "$WINDOW_ID"
fi
