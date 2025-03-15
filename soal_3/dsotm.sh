rosameylin777@rosaaa:/home/Sisop-1-2025-IT20/soal_3$#!/bin/bash

clear

if [ $# -eq 0 ]; then
echo "ketik: ./dsotm.sh --play=\"<Track>\""
echo "Pilih Track yang tersedia:"
echo -e "\e[33m- Speak to Me\e[0m"
echo -e "\e[33m- Time\e[0m"
echo -e "\e[33m- Brain Damage\e[0m"
exit 1
fi
track=$(echo "$1" | awk -F= '{print $2}' | tr -d '"')


speak_to_me() {
echo -e "\e[33mPlaying Speak to Me\e[0m"

while true; do
affirmation=$(curl -s -H "Accept: application/json" "https://www.affirmations.dev" | grep -o '"affirmation":"[^"]*"' | sed 's/"affirmation":"//;s/"//')

echo "$affirmation"

sleep 1

done
}


time_track() {
echo "⏳ Live Clock ⏳"

while true; do
echo -ne "\r📅 $(date '+%Y-%m-%d | %H:%M:%S') ⏰"
sleep 1
done
}


brain_damage() {
while true; do
clear
ps aux --sort=-%mem | head -n 10
sleep 1
done
}

case "$track" in
"Speak to Me") speak_to_me ;;
"Time") time_track ;;
"Brain Damage") brain_damage ;;
*)

echo "Lagu '$track' Not Found!"
exit 1
;;

esac
