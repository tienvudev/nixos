#!/bin/sh

if niri msg --json outputs | jq -e ".\"$1\".current_mode == null"; then
  niri msg output "$1" on
else
  niri msg output "$1" off
fi
