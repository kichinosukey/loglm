#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib.sh"

resolve_lang

if command -v cursor-agent > /dev/null 2>&1; then
  say "Cursor Agent CLI (cursor-agent) は既にインストールされています。" \
      "Cursor Agent CLI (cursor-agent) is already installed."
  exit 0
fi

say "エラー: Cursor Agent CLI (cursor-agent) が PATH 上に見つかりません。" \
    "Error: Cursor Agent CLI (cursor-agent) is not found in your PATH." >&2
say "Cursorの環境設定を確認し、'cursor-agent' コマンドを PATH に追加してから再試行してください。" \
    "Please check your Cursor setup and ensure 'cursor-agent' is available in your PATH, then retry." >&2
exit 1
