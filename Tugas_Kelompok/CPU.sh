#! /bin/bash

# Token Bot Father
TOKEN="6276354396:AAFM0esn0qvK2S0dDk79OqqhVpCS7BDTjgo"

# ID Chat bot
ID_CHAT="6276354396"

# API Telegram
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

# Path Log File
log_file="/home/nasrull/Documents/ShellScript/cpu_usage.log"

# Melihat penggunaan CPU dalam persentase
get_cpu_usage(){
	cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
	cpu_usage=$(printf "%.0f" $cpu_usage)
	echo "$cpu_usage"
}

# Looping
while true; do
	cpu_usage=$(get_cpu_usage)
	current_date=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[$current_date] Penggunan CPU : $cpu_usage%"
	
	sleep 1

# Pengkondisian jika penggunaan CPU >50% maka akan ada pemberitahuan
if [ "$cpu_usage" -ge "5" ]; then
# Mengirimkan informasi penggunaan CPU jika >50%
curl -s -X POST "$URL" -d "chat_id=$ID_CHAT" -d "text=[$timestamp] Penggunaan CPU Sudah Melebihi $cpu_usage"
fi
done
