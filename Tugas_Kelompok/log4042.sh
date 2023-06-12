#!/bin/bash

# Fungsi untuk mengirimkan notifikasi ke Telegram
send_telegram_message() {
    local chat_id="-983501873"
    local bot_token="6276354396:AAFM0esn0qvK2S0dDk79OqqhVpCS7BDTjgo"
    local message="$1"

    curl -s -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" -d chat_id="${chat_id}" -d text="${message}"
}

# Cek apakah ada file access.log yang bisa di-monitor
access_log="/var/log/apache2/access.log"
if [ ! -f "$access_log" ]; then
    echo "File access.log tidak ditemukan."
    exit 1
fi

# File log untuk menyimpan pesan error 404
log_file="/path/to/error.log"

# Membaca file access.log secara real-time dan memeriksa error 404
tail -n0 -f "$access_log" | while read line; do
    if echo "$line" | grep -q ' 404 '; then
        echo "Error 404 terdeteksi!"
        current_date=$(date +"%Y-%m-%d %H:%M:%S")
        error_message=$(printf "[%s]\nError 404: Halaman tidak ditemukan" "$current_date")

        # Menyimpan pesan error 404 ke log file
        echo "$error_message" >> "$log_file"

        # Kirim notifikasi ke Telegram
        send_telegram_message "$error_message"
    fi
done
