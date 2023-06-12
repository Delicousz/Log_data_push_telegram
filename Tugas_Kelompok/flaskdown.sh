#!/bin/bash

# Fungsi untuk mengirimkan notifikasi ke Telegram
send_telegram_message() {
    local chat_id="-983501873"
    local bot_token="6276354396:AAFM0esn0qvK2S0dDk79OqqhVpCS7BDTjgo"
    local message="$1"

    curl -s -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" -d chat_id="${chat_id}" -d text="${message}"
}

# Fungsi untuk memeriksa status Flask
check_flask_status() {
    local flask_url="http://localhost:5000"  # Ganti dengan URL Flask Anda

    local response_code=$(curl -s -o /dev/null -w "%{http_code}" "$flask_url")

    if [ "$response_code" != "200" ]; then
        echo "Flask down!"

        local current_date=$(date +"%Y-%m-%d %H:%M:%S")
        local error_message=$(printf "[%s]\nFlask is down!" "$current_date")
                #error_message=$(printf "[%s]\nError 404: Halaman tidak ditemukan" "$current_date")

        # Menyimpan pesan error ke log file
        echo "$error_message" >> /path/to/error.log

        # Kirim notifikasi ke Telegram
        send_telegram_message "$error_message"
    fi
}

# Memeriksa status Flask setiap 5 detik
while true; do
    check_flask_status
    sleep 5
done
