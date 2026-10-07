# Mpt — MoneyPrinterTurbo siap Codespace (HP-friendly)

Repo kecil ini hanya berisi konfigurasi; kode aplikasi diambil
otomatis dari upstream `harry0703/MoneyPrinterTurbo` saat Codespace dibuat.

## Pakai dari HP (3 ketuk)

1. Buka `https://codespaces.new/attario478-prog/Mpt/main` → `Create` (mesin 2-core).
2. Tunggu `postCreateCommand` selesai (`===== SELESAI =====` di log pembuatan).
3. Di terminal Codespace:
   `cd MoneyPrinterTurbo && MPT_WEBUI_HOST=0.0.0.0 MPT_WEBUI_PORT=8501 sh webui.sh`
4. Tab `PORTS` → `8501` → `Open in Browser` → isi Settings:
   `openrouter` + key, model `minimax/minimax-m3:free`, Pexels key, `subtitle=edge`.

Hasil video: `MoneyPrinterTurbo/storage/tasks/<id>/final-1.mp4` → download dari HP.
`config.toml` tidak di-commit (berisi key).
