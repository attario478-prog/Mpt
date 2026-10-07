#!/usr/bin/env bash
# Jalankan WebUI Streamlit terdetach + server log debug (8502, folder .logs). Aman diulang.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
LOGDIR="$ROOT/.logs"
mkdir -p "$LOGDIR"
cd "$ROOT/MoneyPrinterTurbo" 2>/dev/null || cd /workspaces/Mpt/MoneyPrinterTurbo
export PATH="$HOME/.local/bin:$PATH"

if ! pgrep -f "http.server 8502" >/dev/null 2>&1; then
  setsid -f python3 -m http.server 8502 --directory "$LOGDIR" >/dev/null 2>&1
fi

if pgrep -f "streamlit run" >/dev/null 2>&1; then
  echo "WebUI sudah jalan di 8501"
  exit 0
fi

setsid -f env MPT_WEBUI_HOST=0.0.0.0 MPT_WEBUI_PORT=8501 sh webui.sh >"$LOGDIR/webui.log" 2>&1
sleep 3
echo "WebUI dijalankan, port 8501 (log: .logs/webui.log)"
tail -n 20 "$LOGDIR/webui.log" 2>/dev/null || true
