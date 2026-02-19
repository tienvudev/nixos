#!/bin/sh

LOCAL="$HOME/.local/bin/winvm"

if [ -f "$LOCAL" ] && [ "$LOCAL" != "$0" ]; then
  exec "$LOCAL" "$@"
fi

conf_load() {
  conf="./$1/conf.sh"

  mkdir -p "./$1"
  touch "$conf"
  source "$conf"

  if [ -z "$name" ]; then
    name="$1-$(uuidgen)"
  fi
}

# @cmd
# @arg name <DIR>
# @option --iso <FILE>
# @option --cpu[=4|2|8]
# @option --ram[=8|4|16]
# @option --vnc=8006
# @option --rdp=3389
run() {
  conf_load $argc_name

  printf "%s\n" \
    "name=$name" \
    "rdp=$argc_rdp" \
    >"$conf"

  mkdir -p "./$argc_name/storage"
  mkdir -p "./$argc_name/shared"

  set -- run \
    --rm \
    --name "$name" \
    -e CPU_CORES=$argc_cpu \
    -e RAM_SIZE=${argc_ram}G \
    -e USERNAME=admin \
    -p $argc_vnc:8006 \
    -p $argc_rdp:3389 \
    -v "./$argc_name/storage":/storage \
    -v "./$argc_name/shared":/shared \
    --cap-add NET_ADMIN \
    --device=/dev/kvm \
    --device=/dev/net/tun \
    --stop-timeout 120 \
    -it

  if [ -z "$argc_iso" ]; then
    set -- "$@" -d
  else
    set -- "$@" -v "$(realpath -m "$argc_iso"):/boot.iso"
  fi

  podman "$@" dockurr/windows:5.14
}

# @cmd
# @arg name! <DIR>
stop() {
  conf_load $argc_name

  podman stop "$name"
}

# @cmd
# @arg name! <DIR>
rdp() {
  conf_load $argc_name

  sdl-freerdp \
    /v:127.0.0.1:$rdp \
    /u:admin \
    /p:admin \
    /cert:ignore \
    /kbd:remap:0x15b=0 \
    -grab-keyboard \
    +f
}

eval "$(argc --argc-eval "$0" "$@")"
