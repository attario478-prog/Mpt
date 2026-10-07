#!/usr/bin/env bash
# Jalankan WebUI Streamlit terdetach (setsid) agar survive setelah lifecycle Codespaces.
# Bound 0.0.0.0 supaya port 8501 ter-forward. Aman diulang.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT/MoneyPrinterTurbo" 2>/dev/null || cd /workspaces/Mpt/MoneyPrinterTurbo
export PATH="$HOME/.local/bin:$PATH"

if pgrep -f "streamlit run" >/dev/null 2>&1; then
  echo "WebUI sudah jalan di 8501"
  exit 0
fi

setsid -f env MPT_WEBUI_HOST=0.0.0.0 MPT_WEBUI_PORT=8501 sh webui.sh >"$ROOT/webui.log" 2>&1
sleep 3
echo "WebUI dijalankan, port 8501 (log: $ROOT/webui.log)"
tail -n 20 "$ROOT/webui.log" 2>/dev/null || true
