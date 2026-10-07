#!/usr/bin/env bash
# Setup sekali jalan untuk Codespace Mpt. Log ke ./setup.log agar mudah dibaca.
# Idempotent: aman diulang.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
exec > >(tee -a "$ROOT/setup.log") 2>&1
echo "=== setup mulai $(date -u) ==="

run() { echo "+ $*"; "$@" || echo "!! GAGAL: $* (lanjut)"; }

run sudo apt-get update
run sudo apt-get install -y ffmpeg imagemagick
sudo sed -i '/<policy domain="path" rights="none" pattern="@\*"/d' /etc/ImageMagick-6/policy.xml || true

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"
command -v uv || { echo "!! uv tidak ada"; exit 1; }

if [ ! -d "$ROOT/MoneyPrinterTurbo" ]; then
  run git clone --depth 1 https://github.com/harry0703/MoneyPrinterTurbo.git "$ROOT/MoneyPrinterTurbo"
fi
cd "$ROOT/MoneyPrinterTurbo"
run uv python install 3.11
run uv sync --frozen
[ -f config.toml ] || cp config.example.toml config.toml

echo "=== setup selesai $(date -u) ==="
echo "Isi Settings WebUI: llm_provider=openrouter, model minimax/minimax-m3:free, Pexels key, subtitle=edge."
