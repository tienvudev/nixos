#!/bin/sh

OUTPUT=$(niri msg --json workspaces \
  | jq -r ".[] | select(.is_focused==true) | .output" \
  | head -n1)

[ -z "$OUTPUT" ] && return;


SESSION="niri-pad"

APP="$SESSION-$OUTPUT"

WINDOW=$(niri msg --json windows \
  | jq ".[] | select(.app_id==\"$APP\") | .id" \
  | head -n1)


if [ -n "$WINDOW" ]; then
  niri msg action close-window --id "$WINDOW"
else
  alacritty \
    --class="$APP" \
    -e zellij attach "$SESSION" -c
fi
