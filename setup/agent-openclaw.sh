#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib.sh"

resolve_lang

download_installer() {
  if command -v curl > /dev/null 2>&1; then
    curl -fsSL --proto '=https' --tlsv1.2 https://openclaw.ai/install.sh
    return
  fi
  if command -v wget > /dev/null 2>&1; then
    wget -qO- https://openclaw.ai/install.sh
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
  say "OpenClaw installer の取得には curl または wget が必要です。" \
      "curl or wget is required to fetch the OpenClaw installer." >&2
  return 1
}

say "OpenClaw は experimental サポートです。公式 installer を実行します。" \
    "OpenClaw support is experimental. Running the official installer."
say "OpenClaw installer は Node 22+ の検出・導入と onboarding を処理します。" \
    "The OpenClaw installer handles Node 22+ detection/installation and onboarding."

if ! ensure_download_tool; then
  exit 1
fi

if ! download_installer | bash; then
  say "エラー: OpenClaw のインストールに失敗しました。" \
      "Error: failed to install OpenClaw." >&2
  say "ネットワーク接続または OpenClaw 公式 installer を確認してください。" \
      "Check your network connection or the official OpenClaw installer." >&2
  exit 1
fi

say "OpenClaw のインストール処理が完了しました。" \
    "OpenClaw installation completed."
say "必要に応じて `openclaw doctor` と `openclaw status` で設定を確認してください。" \
    "If needed, verify setup with `openclaw doctor` and `openclaw status`."
