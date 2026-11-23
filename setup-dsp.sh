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

# The devicetree compatible property is a NUL-separated list of strings.
dt_compatible() {
  local compat
  local -a compats=()

  mapfile -d '' -t compats 2>/dev/null < /sys/firmware/devicetree/base/compatible || return 1
  for compat in "${compats[@]}"; do
    [[ "$compat" == "$1" ]] && return 0
  done
  return 1
}

if dt_compatible 'qcom,sc8280xp'; then
  setup_soc_id 460
fi
