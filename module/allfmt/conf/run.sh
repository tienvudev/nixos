#!/bin/sh

CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
RUNNER="$CONFIG/allfmt/run.sh"

if [ -f "$RUNNER" ] && [ "$RUNNER" != "$0" ]; then
  exec "$RUNNER" "$@"
fi

# @arg formatter![treefmt|nix|oxc|sh|toml]
# @arg file!
# @arg args   Argument string passed to treefmt

eval "$(argc --argc-eval "$0" "$@")"

DIR="$(dirname "$0")"

case "$argc_formatter" in
"treefmt")
  treefmt --config-file "$DIR/treefmt.toml" $argc_args $argc_file
  ;;

"nix")
  nixfmt $argc_file
  ;;
"oxc")
  oxfmt $argc_file
  ;;
"sh")
  shfmt -w -i 2 $argc_file
  ;;
"toml")
  tombi format $argc_file
  ;;
esac
