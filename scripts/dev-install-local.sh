#!/usr/bin/env bash
# Install loglm from this repo into ~/.local/bin (overrides curl-based install).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${LOGLM_INSTALL_DIR:-$HOME/.local/bin}"
LOGLM_HOME="${LOGLM_HOME:-$HOME/.local/share/loglm}"
SETUP_SRC="$ROOT_DIR/setup"
SETUP_DST="$LOGLM_HOME/setup"

mkdir -p "$BIN_DIR" "$SETUP_DST"

install_file() {
  local src="$1"
  local dst="$2"
  cp "$src" "$dst"
  chmod +x "$dst"
}

install_file "$ROOT_DIR/loglm" "$BIN_DIR/loglm"
install_file "$ROOT_DIR/loglm-decode" "$BIN_DIR/loglm-decode"
install_file "$ROOT_DIR/loglm-timeline" "$BIN_DIR/loglm-timeline"

for f in "$SETUP_SRC"/*; do
  [[ -f "$f" ]] || continue
  install_file "$f" "$SETUP_DST/$(basename "$f")"
done

echo "Installed local loglm from: $ROOT_DIR"
echo "  $BIN_DIR/loglm"
echo "  $BIN_DIR/loglm-decode"
echo "  $BIN_DIR/loglm-timeline"
echo "Setup scripts: $SETUP_DST"
loglm -v
loglm -h 2>&1 | rg -q -- '--evidence' && echo "OK: --evidence is available" || {
  echo "WARN: --evidence not in help" >&2
  exit 1
}
