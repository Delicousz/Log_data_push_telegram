#!/bin/bash

# Konfigurasi
token="6276354396:AAFM0esn0qvK2S0dDk79OqqhVpCS7BDTjgo"
chatid="-983501873"
log_file="login_notification.log"  # Nama file log yang digunakan

# Mendapatkan informasi pengguna yang login sebelumnya
prev_user=$(who | awk '{print $1}')

# Menunggu sampai ada pengguna baru yang login
while true; do
    # Mendapatkan informasi pengguna yang login saat ini
    cur_user=$(who | awk '{print $1}')

    # Memeriksa apakah ada pengguna baru yang login
    if [ "$prev_user" != "$cur_user" ]; then
        # Ada pengguna baru yang login, mengirim notifikasi ke Telegram
        USERNAME=$(echo "$cur_user" | tail -n 1)
        HOSTNAME=$(hostname)
        LOGIN_TIME=$(date +"%Y-%m-%d %H:%M:%S")
        MESSAGE="User $USERNAME has logged in to $HOSTNAME at $LOGIN_TIME."

        # Mengirim notifikasi ke Telegram
        URL="https://api.telegram.org/bot$token/sendMessage"
        curl -s -X POST $URL -d chat_id=$chatid -d text="$MESSAGE"

        # Menyimpan notifikasi ke dalam log
        echo "$MESSAGE" >> "$log_file"
    fi

    # Mengupdate daftar pengguna yang login sebelumnya
    prev_user="$cur_user"

    # Menunggu selama 1 menit sebelum memeriksa kembali
    sleep 15
done