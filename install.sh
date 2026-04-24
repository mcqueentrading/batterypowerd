#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
SYSTEMD_USER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
SHARE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/batterypowerd"

mkdir -p "$BIN_DIR" "$SYSTEMD_USER_DIR" "$SHARE_DIR"

install -m 0755 "$SCRIPT_DIR/battery_hibernate.sh" "$BIN_DIR/battery_hibernate.sh"
install -m 0755 "$SCRIPT_DIR/battery_status.sh" "$BIN_DIR/battery_status.sh"
install -m 0644 "$SCRIPT_DIR/plot_battery.py" "$SHARE_DIR/plot_battery.py"
install -m 0644 "$SCRIPT_DIR/systemd-user/battery-hibernate.service" "$SYSTEMD_USER_DIR/battery-hibernate.service"
install -m 0644 "$SCRIPT_DIR/systemd-user/battery-hibernate.timer" "$SYSTEMD_USER_DIR/battery-hibernate.timer"

systemctl --user daemon-reload

cat <<'EOF'
Installed:
  ~/.local/bin/battery_hibernate.sh
  ~/.local/bin/battery_status.sh
  ~/.local/share/batterypowerd/plot_battery.py
  ~/.config/systemd/user/battery-hibernate.service
  ~/.config/systemd/user/battery-hibernate.timer

Next steps:
  systemctl --user enable --now battery-hibernate.timer
  systemctl --user status battery-hibernate.timer
EOF
