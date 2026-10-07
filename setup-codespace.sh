#!/usr/bin/env bash
# Setup sekali jalan untuk Codespace Mpt (HP-friendly).
# Dijalankan otomatis via postCreateCommand; aman diulang (idempotent).
set -euo pipefail

# 1. System deps (ffmpeg + imagemagick untuk gabung klip & subtitle)
sudo apt-get update && sudo apt-get install -y ffmpeg imagemagick
sudo sed -i '/<policy domain="path" rights="none" pattern="@\*"/d' /etc/ImageMagick-6/policy.xml || true

# 2. uv (manajer env Python resmi jalur upstream)
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# 3. Ambil upstream MoneyPrinterTurbo (shallow = hemat kuota)
if [ ! -d MoneyPrinterTurbo ]; then
  git clone --depth 1 https://github.com/harry0703/MoneyPrinterTurbo.git MoneyPrinterTurbo
fi
cd MoneyPrinterTurbo
uv python install 3.11
uv sync --frozen
[ -f config.toml ] || cp config.example.toml config.toml

echo '===== SELESAI ====='
echo 'Isi Settings WebUI: llm_provider=openrouter + key, model minimax/minimax-m3:free, pexels key, subtitle=edge.'
