#!/usr/bin/env bash

MAIN="$HOME/.local/bin/allfmt/main.sh"
CONFIG="$(dirname "$0")/config"

if [[ -f "$MAIN" && "$MAIN" != "$0" ]]; then
	exec "$MAIN" "$@"
fi

# @meta version 0.0.0
# @meta binname allfmt

# @cmd
# @arg files+
format() {
	for file in "${argc_files[@]}"; do
		case "${file##*.}" in
		cs)
			csharpier format "$file"
			gawk -i inplace "$file"
			;;
		gawk)
			local temp=$(mktemp)
			gawk -o- -f "$file" >"$temp" && mv "$temp" "$file"
			;;
		nix)
			alejandra "$file" -q
			;;
		css | html | js | json | toml | ts | tsx | yml | yaml)
			oxfmt -c "$CONFIG/oxfmt.json" "$file"
			;;
		sh)
			shfmt -w "$file"
			;;
		esac
	done
}

eval "$(argc --argc-eval "$0" "$@")"
