#!/usr/bin/env bash

conf_load() {
  dir="$(realpath -m "$1")"
  conf="$dir/conf.sh"

  mkdir -p "$dir"
  touch "$conf"
  source "$conf"

  if [[ -z $name ]]; then
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
# @option -p --port*
run() {
  conf_load "$argc_name"

  printf "%s\n" \
    "name=$name" \
    "rdp=$argc_rdp" \
    >"$conf"

  mkdir -p "$dir"/{storage,shared}

  local args=(
    run
    --rm
    --name "$name"
    -e "CPU_CORES=$argc_cpu"
    -e "RAM_SIZE=${argc_ram}G"
    -e "USERNAME=admin"
    -e "DISK_SIZE=128G"
    -p "$argc_vnc:8006"
    -p "$argc_rdp:3389"
    -v "$dir/storage:/storage"
    -v "$dir/shared:/shared"
    --cap-add NET_ADMIN
    --device=/dev/kvm
    --device=/dev/net/tun
    --stop-timeout 120
    -it
  )

  if [[ -n ${argc_port[@]} ]]; then
    for i in "${argc_port[@]}"; do
      args+=(-p "$i")
    done

    local ports=("${argc_port[@]##*:}")

    local user_ports=$(
      IFS=,
      echo "${ports[*]}"
    )

    args+=(-e "USER_PORTS=$user_ports")
  fi

  if [[ -z $argc_iso ]]; then
    args+=(-d)
  else
    args+=(-v "$(realpath -m "$argc_iso"):/boot.iso")
  fi

  # echo "${args[@]}"
  podman "${args[@]}" dockurr/windows:5.14
}

# @cmd
# @arg name! <DIR>
stop() {
  conf_load "$argc_name"

  podman stop "$name"
}

# @cmd
# @arg name! <DIR>
# @option -s --scale[=100|140|180]
rdp() {
  conf_load "$argc_name"

  # TODO: custom scale
  SDL_VIDEODRIVER=wayland \
    sdl-freerdp \
    /v:127.0.0.1:$rdp \
    /u:admin \
    /p:admin \
    /cert:ignore \
    /kbd:remap:0x15b=0 \
    /scale:$argc_scale \
    -grab-keyboard \
    +f
}

eval "$(argc --argc-eval "$0" "$@")"
