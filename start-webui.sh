#!/usr/bin/env bash
# Jalankan WebUI Streamlit di background, bound 0.0.0.0 agar port ter-forward Codespaces.
# Dipanggil postStartCommand setiap Codespace menyala; aman diulang.
set -uo pipefail
cd "$(dirname "$0")/MoneyPrinterTurbo" 2>/dev/null || cd /workspaces/Mpt/MoneyPrinterTurbo
export PATH="$HOME/.local/bin:$PATH"

if pgrep -f "streamlit run" >/dev/null 2>&1; then
  echo "WebUI sudah jalan di 8501"
  exit 0
fi

nohup env MPT_WEBUI_HOST=0.0.0.0 MPT_WEBUI_PORT=8501 sh webui.sh >/tmp/webui.log 2>&1 &
echo "WebUI start di background -> http://0.0.0.0:8501 (log: /tmp/webui.log)"
