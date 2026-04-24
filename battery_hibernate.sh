#!/usr/bin/env bash

set -euo pipefail

BAT_PATH="${BATTERYPOWERD_BAT_PATH:-/sys/class/power_supply/BAT0/capacity}"
STATE_PATH="${BATTERYPOWERD_STATE_PATH:-/sys/class/power_supply/BAT0/status}"
THRESHOLD_LOW="${BATTERYPOWERD_THRESHOLD_LOW:-0}"
THRESHOLD_HIGH="${BATTERYPOWERD_THRESHOLD_HIGH:-11}"
HIBERNATE_COMMAND="${BATTERYPOWERD_HIBERNATE_COMMAND:-systemctl hibernate -i}"

[ -f "$BAT_PATH" ] && [ -f "$STATE_PATH" ] || exit 1

BATTERY=$(<"$BAT_PATH")
STATE=$(<"$STATE_PATH")
BATTERY=${BATTERY//%/}

if [[ "$STATE" == "Discharging" ]] \
   && [ "$BATTERY" -ge "$THRESHOLD_LOW" ] \
   && [ "$BATTERY" -le "$THRESHOLD_HIGH" ]; then
    eval "$HIBERNATE_COMMAND"
fi
