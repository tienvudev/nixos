#!/bin/sh

LOCAL="$HOME/.local/bin/allfmt/run.sh"

if [ -f "$LOCAL" ] && [ "$LOCAL" != "$0" ]; then
  exec "$LOCAL" "$@"
fi

DIR="$(dirname "$0")"

# @arg fmt![treefmt|nix|oxc|sh|toml]
# @arg file!
# @arg args   Argument string passed to treefmt

eval "$(argc --argc-eval "$0" "$@")"

case "$argc_fmt" in
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
