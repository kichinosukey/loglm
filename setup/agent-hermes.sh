#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib.sh"

resolve_lang

download_installer() {
  if command -v curl > /dev/null 2>&1; then
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh
    return
  fi
  if command -v wget > /dev/null 2>&1; then
    wget -qO- https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh
    return
  fi
  return 1
}

ensure_download_tool() {
  if command -v curl > /dev/null 2>&1 || command -v wget > /dev/null 2>&1; then
    return 0
  fi
  if command -v apt-get > /dev/null 2>&1; then
    say "curl / wget が見つからないため、curl をインストールします..." \
        "curl/wget not found; installing curl..."
    run_as_root apt-get update
    run_as_root apt-get install -y curl
    command -v curl > /dev/null 2>&1 && return 0
  fi
  say "Hermes Agent installer の取得には curl または wget が必要です。" \
      "curl or wget is required to fetch the Hermes Agent installer." >&2
  return 1
}

say "Hermes Agent は experimental サポートです。公式 installer を実行します。" \
    "Hermes Agent support is experimental. Running the official installer."
say "Hermes installer は uv / Python / Node.js などの依存関係を処理します。" \
    "The Hermes installer handles dependencies such as uv, Python, and Node.js."

if ! ensure_download_tool; then
  exit 1
fi

if ! download_installer | bash; then
  say "エラー: Hermes Agent のインストールに失敗しました。" \
      "Error: failed to install Hermes Agent." >&2
  say "ネットワーク接続または Hermes Agent 公式 installer を確認してください。" \
      "Check your network connection or the official Hermes Agent installer." >&2
  exit 1
fi

say "Hermes Agent のインストール処理が完了しました。" \
    "Hermes Agent installation completed."
say "必要に応じて `hermes doctor` と `hermes setup` で設定を確認してください。" \
    "If needed, verify setup with `hermes doctor` and `hermes setup`."
