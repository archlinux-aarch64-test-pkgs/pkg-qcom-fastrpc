#!/bin/bash

setup_soc_id() {
  local soc_id="$1"
  local fake_soc_id='/tmp/fake-soc0/soc_id'

  if [[ -f "$fake_soc_id" ]]; then
    return
  fi

  mkdir -p "${fake_soc_id%/*}"
  printf '%s\n' "$soc_id" > "$fake_soc_id"
  mount --bind "$fake_soc_id" /sys/devices/soc0/soc_id
}

case "$(cat /sys/firmware/devicetree/base/model 2>/dev/null)" in
  'Radxa Dragon Q8B'|'Radxa DragonBay 4 Pro'|'Radxa DragonStation 6')
    setup_soc_id 460
    ;;
esac
