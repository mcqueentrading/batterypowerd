#!/usr/bin/env bash

set -euo pipefail

BAT="${BATTERYPOWERD_UPOWER_DEVICE:-/org/freedesktop/UPower/devices/battery_BAT0}"
INTERVAL="${BATTERYPOWERD_STATUS_INTERVAL:-5}"

while true; do
    PERC=$(upower -i "$BAT" | awk '/percentage:/ {print $2}')
    STATE=$(upower -i "$BAT" | awk '/state:/ {print $2}')
    echo -ne "\rBattery: $PERC ($STATE)   "
    sleep "$INTERVAL"
done
