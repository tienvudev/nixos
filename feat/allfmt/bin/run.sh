#!/usr/bin/env bash

# @arg file!
# @flag --stdin

# FORMATER

fmt_csharpier() {
  local args_cs=(--config-path "$DIR/csharpier.yaml")
  local args_gawk=(-f "$DIR/csharpier.gawk")

  if [[ -n $STDIN ]]; then
    args_cs+=(--stdin-path "$FILE")
  else
    args_cs+=("$FILE")
    args_gawk+=(-i inplace "$FILE")
  fi

  if [[ -n $STDIN ]]; then
    csharpier format "${args_cs[@]}" | gawk "${args_gawk[@]}"
  else
    csharpier format "${args_cs[@]}"
    gawk "${args_gawk[@]}"
  fi
}

fmt_dprint() {
  local args=(-c "$DIR/dprint.json")

  [[ -n $STDIN ]] && args+=(--stdin)

  DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 dprint fmt "${args[@]}" "$FILE"
}

fmt_gawk() {
  if [[ -n $STDIN ]]; then
    gawk -o- -f -
  else
    tmp=$(mktemp)
    gawk -o- -f "$FILE" >"$tmp" && mv "$tmp" "$FILE"
  fi
}

fmt_nix() {
  local args_nix=()
  local args_awk=(-f "$DIR/nixfmt.awk")

  if [[ -n $STDIN ]]; then
    args_nix+=(-f)
  else
    args_awk+=(-i inplace "$FILE")
  fi

  nixfmt "${args_nix[@]}" "$FILE"
  # TODO: deal with stdin
  # awk "${args_awk[@]}"
}

fmt_oxc() {
  local args=(-c "$DIR/oxfmt.json")

  [[ -n $STDIN ]] && args+=(--stdin-filepath)

  oxfmt "${args[@]}" "$FILE"
}

fmt_sh() {
  local args=(-i 2)

  [[ -z $STDIN ]] && args+=(-w "$FILE")

  shfmt "${args[@]}"
}

fmt_tombi() {
  local args=()

  [[ -n $STDIN ]] && args+=(--stdin-filepath)

  tombi format "${args[@]}" "$FILE"
}

# MAIN

RUN="$HOME/.local/bin/allfmt/run.sh"

if [[ -f $RUN && $RUN != $0 ]]; then
  exec "$RUN" "$@"
fi

eval "$(argc --argc-eval "$0" "$@")"

DIR="$(dirname "$0")"
FILE="$argc_file"
STDIN="$argc_stdin"

case "${FILE##*.}" in
cs)
  fmt_csharpier
  ;;
gawk)
  fmt_gawk
  ;;
nix)
  fmt_nix
  ;;
json | yml | yaml | css | js | ts | tsx)
  fmt_oxc
  ;;
"sh")
  fmt_sh
  ;;
toml)
  fmt_sh
  ;;
esac

# STDIN="$STDIN"

# case "${argc_file##*.}" in
#   "sh")
#     if [ -n "$STDIN" ]; then
#       shfmt $SHFMT_CFG "$FILE"
#     else
#       shfmt $SHFMT_CFG
#   ;;
# esac

# case "$argc_fmt" in
# "treefmt")
#   treefmt \
#     --config-file "$DIR/treefmt.toml" \
#     --tree-root "$(pwd)" \
#     $argc_args "$FILE"
#   ;;
# "nix")
#   nixfmt "$FILE"
#   awk -f "$DIR/nix.awk" -i inplace "$FILE"
#   ;;
# "oxc")
#   oxfmt -c "$DIR/oxfmt.json" "$FILE"
#   ;;
# "sh")
#   shfmt -w -i 2 "$FILE"
#   ;;
# "toml")
#   tombi format "$FILE"
#   ;;
# "cs")
#   echo Foo
#   dprint fmt -c "$DIR/dprint.json" --stdin "$FILE"
#   ;;
# esac
