#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib.sh"

resolve_lang

if command -v agy > /dev/null 2>&1; then
  say "Antigravity CLI (agy) は既にインストールされています。" \
      "Antigravity CLI (agy) is already installed."
  exit 0
fi

say "エラー: Antigravity CLI (agy) が PATH 上に見つかりません。" \
    "Error: Antigravity CLI (agy) is not found in your PATH." >&2
say "Antigravityの利用環境をセットアップしてから再試行してください。" \
    "Please set up the Antigravity environment before running loglm." >&2
exit 1
