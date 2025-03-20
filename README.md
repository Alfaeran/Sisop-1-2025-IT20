# Modul 1 Sistem Operasi 2025
- **Mey Rosalina NRP 5027241004**
- **Rizqi Akbar Sukirman Putra NRP 5027241044**
- **M. Alfaeran Auriga Ruswandi NRP 5027241115**

# Laporan Resmi Modul 1
# Soal 1
Membuat file bernama poppo_siroyo.sh dan mendownload reading_data.csv yang diberikan melalui soal.
```
#!/bin/bash

while (true); do
echo "Selamat datang habibi. Silahkan memilih ingin menampilkan apa. Berikut pilihannya:"
echo "1. Chris Hemsworth membaca buku berapa banyak sih?"
echo "2. Penasaran sama rata-rata orang membaca pakai tablet?"
echo "3. Buku dengan rating tertinggi apa sih?"
echo "4. Genre paling populer di Asia setelah tahun 2023 apa sih?"
echo "5. Exit"
echo -n "Pilih mana? : "
read answer
```
Akan menampilkan pilihan yang akan dipilih oleh reader dan jawaban akan disimpan ke dalam variabel "answer"

**a. Membuat kode yang dapat menampilkan data banyak buku yang dibaca oleh "Chris Hemsworth"**
```
case "$answer" in
"1")
awk '/Chris Hemsworth/ {n++}
END {print "Chris Hemsworth membaca sebanyak", n, "buku"}' reading_data.csv
echo "ga kayak kamu yang ga pernah baca buku"
;;
```
Dengan menggunakan case, pilihan pertama adalah menampilkan banyak buku yang dibaca oleh Chris Hemsworth. Dengan menggunakan awk, dapat mencari data yang berisikan Chris Hemsworth dan diincrement.
Hingga END yang akan menampilkan output:
```
Pilih mana? : 1
Chris Hemsworth membaca sebanyak 56 buku
ga kayak kamu yang ga pernah baca buku
```

**b. Membuat kode menampilkan rata-rata durasi pembaca yang menggunakan tablet**
```
"2")
awk -F',' 'NR>1 && $8=="Tablet" {sum+=$6; count++}
END {printf "Rata-rata durasi membaca dengan Tablet adalah %.1f menit.\n", sum/count}' reading_data.csv
;;
```
Dengan menggunakan awk dan dibedakan menggunakan tanda koma (,) karena file yang dibaca adalah file csv, serta dengan $8 yang berada di tabel penggunakan baca kita hanya memilih tablet.
Untuk menghitung rata-rata diperlukan sum dari seluruh durasi tablet dan jumlah pengguna yang menggunakan tablet. Hingga END yang akan menampilkan output :
```
Pilih mana? : 2
Rata-rata durasi membaca dengan Tablet adalah 152.4 menit.
```

**c. Membuat kode menampilkan pembaca dengan rating tertinggi**
```
"3")
awk -F',' 'NR>1 {if ($7>max) {max=$7; name=$2; book=$3}}
END {printf "Pembaca dengan rating tertinggi ialah %s - %s - %.lf\n", name, book, max}' reading_data.csv
;;
```
Dengan menggunakan awk, dibedakan menggunakan tanda koma, menggunakan if pada tabel ke 7 untuk mencari rating tertinggi. Jika telah ditemukan rating tertinggi, akan tersimpan ke dalam variabel max, nama, dan book.
Hingga END akan menghasilkan output :
```
Pilih mana? : 3
Pembaca dengan rating tertinggi ialah Robert Downey Jr. - Deep Space Mysteries - 6
```

**d. Membuat kode menampilkan buku yang sering dibaca setelah Desember 31, 2023**
```
"4")
awk -F',' 'BEGIN {max_count=0}
NR>1 && $9=="Asia" &&  $5>"2023-12-31" {count[$4]++}
END {
        for (genre in count) {
                if (count[genre] > max_count) {
                        max_count = count[genre];
                        popular_genre = genre;
                }
        }
printf "Genre paling populer di Asia setelah tahun 2023 adalah: %s sebanyak %i buku\n", popular_genre, max_count}' read>;;
```
Menggunakan awk dan dibedakan menggunakan tanda koma, memulai kode dengan BEGIN untuk melakukan count dan hanya memfokuskan pada kolom $9 yang hanya ada "Asia" dan $5 yang lebih dari 31 Desember 2023, dan count pada $4 akan bertambah.
Pada END akan melakukan for loop untuk mengganti isi variable yang berubah menjadi buku yang paling diminati di Asia setelah 31 Desember 2023. Sehingga outputnya:
```
Pilih mana? : 4
Genre paling populer di Asia setelah tahun 2023 adalah: Mystery sebanyak 14 buku
```

**Tambahan**

Untuk kode, menggunakan fungsi continue sehingga setelah kita menjalankan dan memilih salah satu opsi akan terus berlanjut hingga pengguna memilih exit.

# Soal 2
**a.** Membuat dua shell script, login.sh dan register.sh, yang dimana database “Player” disimpan di /data/player_data.csv. Untuk register, parameter yang dipakai yaitu email, username, dan password. Untuk login, parameter yang dipakai yaitu email dan password.

##register.sh
```
#!/bin/bash

db_directory="data"
db_path="data/player_data.csv"

salt="IT-20-rawrrrr!"

if [ ! -d "$db_directory" ]; then
    echo "Directory $db_directory does not exist. Creating..."
    mkdir -p "$db_directory"
    echo "Directory $db_directory created."
fi

if [ ! -f "$db_path" ]; then
    echo "email,username,password" > "$db_path"
fi

register.player(){

validate_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

validate_password() {
    if [[ ${#1} -lt 8 ]]; then
        echo "Password must be at least 8 characters long."
        return 1
    elif ! [[ "$1" =~ [A-Z] ]]; then
        echo "Password must contain at least one uppercase letter."
       return 1
    elif ! [[ "$1" =~ [0-9] ]]; then
        echo "Password must contain at least one number."
        return 1
    else
        return 0
    fi
}

hashing(){
echo -n "$1$salt" | sha256sum | awk '{print $1}'

}

generate_id (){
max_id=$(tail -n +2 "$db_path" | cut -d ',' -f1 | sort -n | tail -n 1)
    if [ -z "$max_id" ]; then
    echo "1"

    else
        echo $((max_id + 1))
    fi

}

echo "Enter your email:"
read email

if ! validate_email "$email"; then
    echo "Invalid email format. Please enter a valid email address."
    return 1
fi

echo "Enter your username:"
read username

if grep -q "$email" "$db_path"; then
    echo "This email is already registered. Please log in instead."
     sleep 1
	./terminal.sh
fi

while true; do
    echo "Enter your password:"
    read -s password
    if ! validate_password "$password"; then
        echo "Please try again."
    else
        break
    fi
done

hashed_password=$(hashing "$password")

player_id=$(generate_id)

if grep -q "$email" "$db_path"; then
    echo "Email already registered. Please use a different email."
    exit 1
fi

echo "$player_id,$email,$username,$hashed_password" >> "$db_path"
echo "Registration successful! Im waiting for you to come soldier!"
}

register.player
```        

- Memeriksa, membuat, lalu menyimpan database player yanf berisi email,username,password di /data/player_data.csv
  ```
  db_directory="data"
  db_path="data/player_data.csv"  
  if [ ! -d "$db_directory" ]; then
    echo "Directory $db_directory does not exist. Creating..."
    mkdir -p "$db_directory"
    echo "Directory $db_directory created."
  fi

  if [ ! -f "$db_path" ]; then
            echo "email,username,password" > "$db_path"
  fi
  ```
**b.** Fungsi validasi email yang dimana user harus memasukan email ....@.... , jika tidak maka user harus mencoba kembali input email
  ```
  validate_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
  }
  ```
**b.** Fungsi validasi password yang dimana password harus memuat minimal 8 karakter, minimal 1 uppercase alphabet, dan minimal 1 angka.
  ```
  validate_password() {
    if [[ ${#1} -lt 8 ]]; then
        echo "Password must be at least 8 characters long."
        return 1
    elif ! [[ "$1" =~ [A-Z] ]]; then
        echo "Password must contain at least one uppercase letter."
       return 1
    elif ! [[ "$1" =~ [0-9] ]]; then
        echo "Password must contain at least one number."
        return 1
    else
        return 0
    fi
  }
  ```
**c.** Memeriksa apakah email yang didaftarkan sudah ada di database atau belum, jika belum makan input user akan masuk ke database player /data/player_data.csv.

- Membaca input email, username, password dari user dan memeriksa format password yang di input oleh user menggunakan fungsi validasi password.
```
  echo "Enter your email:"
  read email
        
  if ! validate_email "$email"; then
       echo "Invalid email format. Please enter a valid email address."
       return 1
  fi
        
  echo "Enter your username:"
  read username
        
  if grep -q "$email" "$db_path"; then
      echo "This email is already registered. Please log in instead."
       sleep 1
          ./terminal.sh
  fi
        
        while true; do
            echo "Enter your password:"
            read -s password
            if ! validate_password "$password"; then
                echo "Please try again."
            else
                break
            fi
        done
if grep -q "$email" "$db_path"; then
    echo "Email already registered. Please use a different email."
    exit 1
fi

echo "$player_id,$email,$username,$hashed_password" >> "$db_path"
echo "Registration successful! Im waiting for you to come soldier!"
}
register.player
  ```
**d.** Mengenkripsi password dengan fungsi hashing Menggabungkan nilai input dengan string "salt" untuk meningkatkan keamanan menggunakan sha256sum dan fungsi generate id untuk mengambil kolom pertama yang akan diisi ID.
  ```
  salt="IT-20-rawrrrr!"
  hashing(){
  echo -n "$1$salt" | sha256sum | awk '{print $1}'

  }

  generate_id (){
  max_id=$(tail -n +2 "$db_path" | cut -d ',' -f1 | sort -n | tail -n 1)
    if [ -z "$max_id" ]; then
    echo "1"

    else
        echo $((max_id + 1))
    fi

  }

hashed_password=$(hashing "$password")

player_id=$(generate_id)
  ```
## login.sh
```
#!/bin/bash

db_directory="data"
db_path="$db_directory/player_data.csv"

salt="IT-20-rawrrrr!"

player.login (){

if [ ! -f "$db_path" ]; then
    echo "No users have registered yet."
    sleep 1
fi


hashing() {
    echo -n "$1$salt" | sha256sum | awk '{print $1}'
}

attempt=0
max_attempts=3

echo "Enter your email:"
read email

user_found=$(grep "$email" "$db_path")

if [ -z "$user_found" ]; then
    echo "Email not registered. Please register first."
    sleep 1
	./terminal.sh
fi

while [ "$attempt" -lt "$max_attempts" ]; do

echo "Enter your password:"
read -s password

hashed_password=$(hashing "$password")

if echo "$user_found" | grep -q "$hashed_password"; then
    echo "Login successful!"
    sleep 1
    exec ./script/manager.sh
else
    echo "Invalid password. Please try again."
    sleep 0
	((attempt++))
fi

if [[ $attempt -eq $max_attempts ]]; then
            echo "Too many failed attempts. Exiting..."
            exit 1

fi
done
}

player.login
```
**e.** Setelah sukses login, "Player" perlu memiliki akses ke sistem pemantauan sumber daya. Sistem harus dapat melacak penggunaan CPU (dalam persentase)
```
 if echo "$user_found" | grep -q "$hashed_password"; then
    echo "Login successful!"
    sleep 1
    exec ./script/manager.sh
else
    echo "Invalid password. Please try again."
    sleep 0
	((attempt++))
fi
```
- **core_monitor.sh
```
#!/bin/bash

cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))

cpu_model=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')

echo "[$(date)] - Penggunaan CPU: $cpu_usage% - Terminal Model [$cpu_model]"
```
**f.** Selain CPU, “fragments” juga perlu dipantau untuk memastikan equilibrium dunia “Arcaea”. RAM menjadi representasi dari “fragments” di dunia “Arcaea”, yang dimana dipantau dalam persentase usage, dan juga penggunaan RAM sekarang. 

- **frag_monitor.sh**
```
  
#!/bin/bash

total_memory=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
available_memory=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
used_memory=$((total_memory - available_memory))
percentage_memory=$(awk "BEGIN {print ($used_memory / $total_memory) * 100}")

total_memoryMB=$((total_memory/1024))
available_memoryMB=$((available_memory/1024))
used_memoryMB=$((used_memory/1024))


echo "[$(date)] - Fragment Usage [$percentage_memory%] - Fragment Count [$used_memoryMB MB] - Details [Total: $total_memoryMB MB, Available: $available_memoryMB MB]"
```
**g.** Pemantauan yang teratur dan terjadwal sangat penting untuk mendeteksi anomali. Crontab manager (suatu menu) memungkinkan "Player" untuk mengatur jadwal pemantauan sistem. 
Hal yang harus ada di fungsionalitas menu; Add/Remove CPU [Core] Usage, Add/Remove RAM [Fragment] Usage, View Active Jobs.
- **manager.sh**
```
#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

script_cpu_monitor="/home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/script/core_monitor.sh"
script_ram_monitor="/home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/script/frag_monitor.sh"

interval="* * * * *"

crontab.menu(){

clear

echo -e "${YELLOW}"
echo                             "╔════════════════════════════════════╗"
echo                             "║        WELCOME TO ARCAEA           ║"
echo                             "║        CRONTAB MANAGEMENT          ║"
echo                             "╚════════════════════════════════════╝"
echo                             "======================================"
echo                             "|           CHOOSE an OPTION         |"
echo                             "======================================"
echo                             "| 1. Add CPU Monitor                 |"
echo                             "======================================"
echo                             "| 2. Add RAM Monitor                 |"
echo                             "======================================"
echo                             "| 3. Remove CPU Monitor              |"
echo                             "======================================"
echo                             "| 4. Remove RAM Monitor              |"
echo                             "======================================"
echo                             "| 5. View Scheduled Monitoring Jobs  |"
echo                             "======================================"
echo                             "| 6. Exit                            |"
echo                             "======================================"
echo -e "${NC}"
read -p "$(echo -e "${CYAN}Choose an option: ${NC}") " option


case $option in
        1) add_cpu_monitor ;;
        2) add_ram_monitor ;;
        3) remove_cpu_monitor ;;
        4) remove_ram_monitor ;;
        5) view_crontab ;;
        6) echo -e "${RED}Exiting...${NC}" && exit 1 ;;
        *) echo -e "${RED}Invalid option!${NC}" && sleep 1 && crontab.menu ;;
    esac

}

add_cpu_monitor(){
(crontab -l 2>/dev/null; echo "$interval bash $script_cpu_monitor  >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/core.log") | crontab -
echo -e "${GREEN}CPU monitoring added!${NC}"
sleep 1
crontab.menu

}

add_ram_monitor() {
(crontab -l 2>/dev/null; echo "$interval bash $script_ram_monitor >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/fragment.log") | crontab -
echo -e "${GREEN}RAM monitoring added!${NC}"
sleep 1
crontab.menu

}

remove_cpu_monitor() {
crontab -l | grep -v "$script_cpu_monitor" | crontab -
echo -e "${YELLOW}CPU monitoring removed!${NC}"
sleep 1
crontab.menu

}

remove_ram_monitor() {
crontab -l | grep -v "$script_ram_monitor" | crontab -
echo -e "${YELLOW}RAM monitoring removed!${NC}"
sleep 1
crontab.menu

}

view_crontab() {
echo -e "${CYAN}Current Scheduled Jobs:${NC}"
    crontab -l
    read -p "Press Enter to return..." 
crontab.menu

}

crontab.menu
```
- Fungsi add/remove cpu
```
add_cpu_monitor(){
(crontab -l 2>/dev/null; echo "$interval bash $script_cpu_monitor  >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/core.log") | crontab -
echo -e "${GREEN}CPU monitoring added!${NC}"
sleep 1
crontab.menu

remove_cpu_monitor() {
crontab -l | grep -v "$script_cpu_monitor" | crontab -
echo -e "${YELLOW}CPU monitoring removed!${NC}"
sleep 1
crontab.menu

}
```
-Fungsi add/remove ram
```
add_ram_monitor() {
(crontab -l 2>/dev/null; echo "$interval bash $script_ram_monitor >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/fragment.log") | crontab -
echo -e "${GREEN}RAM monitoring added!${NC}"
sleep 1
crontab.menu

remove_ram_monitor() {
crontab -l | grep -v "$script_ram_monitor" | crontab -
echo -e "${YELLOW}RAM monitoring removed!${NC}"
sleep 1
crontab.menu

}
```
- view active jobs
```
view_crontab() {
echo -e "${CYAN}Current Scheduled Jobs:${NC}"
    crontab -l
    read -p "Press Enter to return..." 
crontab.menu

}
```
**h.**  Membuat log file, core.log dan fragment.log di folder ./log/, yang dimana masing-masing terhubung ke program usage monitoring untuk usage tersebut. 
```
* * * * * bash /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/script/core_monitor.sh >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/core.log
* * * * * bash /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/script/frag_monitor.sh >> /home/auriga/Documents/Praktikum_sisop-MODUL1/soal_2/logs/fragment.log
# Output sample
[Thu Mar 20 02:30:02 PM WIB 2025] - Core Usage [3,26633%%] - Terminal Model [AMD Ryzen 7 5800H with Radeon Graphics]
[Thu Mar 20 02:31:01 PM WIB 2025] - Fragment Usage [38,2039%] - Fragment Count [5879 MB] - Details [Total: 15389 MB, Available: 9509 MB]
```
**i.**  Sistem harus memiliki antarmuka utama yang menggabungkan semua komponen. Ini akan menjadi titik masuk bagi "Player" untuk mengakses seluruh sistem. Buatlah shell script terminal.sh, yang berisi user flow berikut; Register, Login, Crontab manager (add/rem core & fragment usage) - Exit, Exit.
```
#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m'

clear

animate_text() {
    text="=======WELCOME TO THE ARCAEA SYSTEM======="
    echo -ne "${YELLOW}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep 0.1  # Waktu jeda antar huruf
    done
    echo -e "${NC}"
}


loading_animation() {
    echo -ne "${CYAN}Loading"
    for i in {1..3}; do
        echo -ne "."
        sleep 0.5
    done
    echo -e "${NC}"
    sleep 0.5
}

echo -e "${MAGENTA}"
echo " █████╗ ██████╗  ██████╗███████╗ █████╗"
echo "██╔══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗"
echo "███████║██████╔╝██║     █████╗  ███████║"
echo "██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██║"
echo "██╔══██║██╔══██╗██║     ██╔══╝  ██╔══██║"
echo "██║  ██║██║  ██║╚██████╗███████╗██║  ██"
echo " ═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${YELLOW}"
animate_text
echo -e "${NC}"
loading_animation

while true; do

 clear
echo -e "${CYAN}"
echo "╔════════════════════════════════════╗"
echo "║              MAIN MENU             ║"
echo "╠════════════════════════════════════╣"
echo "║  1.Register                        ║"
echo "║  2.Login                           ║"
echo "║  3.Exit                            ║"
echo "╚════════════════════════════════════╝"
echo -e "${NC}"

read -p "$(echo -e "${YELLOW}Choose an option: ${NC}") " choice

case $choice in

        1)
	    echo -e "${GREEN}Redirecting to registration...${NC}"
            sleep 1
            ./register.sh
            ;;
        2)
            echo -e "${BLUE}Redirecting to login...${NC}"
            sleep 1
            ./login.sh
            ;;
        3)
            echo -e "${RED}Goodbye! T_T${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option! Please choose again.${NC}"
            sleep 1
            ;;
    esac
done
```



# Soal 3
Membuat file bernama dsotm.sh kemudian membuat script Bash bertema album The Dark Side of the Moon (Pink Floyd) dengan lima lagu pilihan:
1. Speak to Me – Menampilkan kata-kata afirmasi dari API setiap detik
2. On the Run – Menampilkan progress bar yang berjalan dengan interval random
3. Time – Menampilkan jam yang diperbarui setiap detik
4. Money – Menampilkan efek mirip cmatrix, tetapi menggunakan simbol mata uang
5. Brain Damage – Menampilkan daftar proses yang sedang berjalan seperti task manager yang diperbarui setiap detik
Program harus membersihkan terminal sebelum berjalan dan dijalankan dengan format. **./dsotm.sh --play="<Track>"**
```
$#!/bin/bash

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
```
code tersebut berfungsi untuk memeriksa apakah pengguna sudah memasukkan lagu yang mau dijalankan atau belum. Kalau nggak ada input, script bakal muncul dan ngasih tahu cara pakainya dan juga daftar lagu yang bisa dipilih. Kalau ada input, kode bakal ngambil nama lagunya dari argumen yang diketik, biar bisa diproses lebih lanjut di script.

**a. Speak to Me**
```
speak_to_me() {
echo -e "\e[33mPlaying Speak to Me\e[0m"

while true; do
affirmation=$(curl -s -H "Accept: application/json" "https://www.affirmations.dev" | grep -o '"affirmation":"[^"]*"' | sed 's/"affirmation":"//;s/"//')

echo "$affirmation"

sleep 1

done
}
```
Kode ini menjalankan fitur Speak to Me, yang pertama-tama akan menampilkan teks "Playing Speak to Me" dalam warna kuning. Setelah itu, program akan terus mengambil kata-kata afirmasi dari API affirmations.dev setiap satu detik dan menampilkannya di terminal. Proses ini berjalan tanpa henti sampai pengguna menghentikannya secara manual


# Soal 4
Membuat file bernama pokemon_analysis.sh dan mendownload file data dari soal bernama pokemon_usage.csv
```
#!/bin/bash

data=$(awk -F',' 'NR==0 {header=$0; next} {print $0} END {print header}' pokemon_usage.csv)

while (true); do
echo "Welcome to Pokemon Analysis home screen. Please select a menu: "
echo "1. Pokemon Info (max Usage and Raw Usage)"
echo "2. Sort Pokemon"
echo "3. Search Pokemon by Name"
echo "4. Search Pokemon by type"
echo "5. Help screen"
echo "6. Exit"
echo -n "Answer: "
read amba
```
variabel data bertujuan untuk penggunaan dalam sorting, serach by name dan type.
Untuk tampilan awal akan menampilkan pilihan yang akan dipilih oleh penggguna dan jawaban akan dimasukkan ke dalam variabel "amba".

**a. Melihat summary dari data**
```
"1")
       awk -F',' 'NR>1 {
            if ($2 > maxusage) {maxusage = $2; poke_name = $1}
            if ($3 > maxraw) {maxraw = $3; pokemon = $1}
        }
        END {
            printf "Highest Usage: %s (%.2f%%)\n", poke_name, maxusage
            printf "Highest Raw Usage: %s (%.0f uses)\n", pokemon, maxraw
        }' pokemon_usage.csv
        ;;
```
Menggunakan awk untuk membaca file dan dibedakan dengan tanda koma serta NR>1 yang bertujuan untuk header tidak diikutkan. Dengan menggunakan if untuk mencari max usage dan max raw_usage yang akan disimpan ke dalam variabel maxusage dengan poke_name dan maxraw dengan pokemon. Sehingga END akan menampilkan hasil :
```
Answer: 1
Highest Usage: Iron Moth (9.53%)
Highest Raw Usage: Great Tusk (563831 uses)
```

**b. Mengurutkan pokemon berdasarkan data kolom**
```
"2")
        echo "Select sorting option:"
        echo "1) Usage%"
        echo "2) Raw Usage"
        echo "3) Name"
        echo "4) HP"
        echo "5) Attack"
        echo "6) Defense"
        echo "7) Special Attack"
        echo "8) Special Defense"
        echo "9) Speed"
        echo -n "Enter your choice: "
        read fufu

        case "$fufu" in
            "1") column=2; order="-nr";;
            "2") column=3; order="-nr";;
            "3") column=1; order="";;
            "4") column=6; order="-nr";;
            "5") column=7; order="-nr";;
            "6") column=8; order="-nr";;
            "7") column=9; order="-nr";;
            "8") column=10; order="-nr";;
            "9") column=11; order="-nr";;
          *)
                echo "Please select a valid sorting option!"
                continue
                ;;
        esac

        echo "$data" | head -n 1
        echo "$data" | tail -n +2 | sort -t ',' $order -k"$column"
        ;;
```
Menampilkan pilihan dalam bentuk case, jawaban akan disimpan ke dalam variabel fufu. Dan semua case menggunakan order untuk mensort kolom. Pada bagian akhir akan menampilkan header dari tabel. 
Sehingga output yang dihasilkan berupa :
```
Answer: 2
Select sorting option:
1) Usage%
2) Raw Usage
3) Name
4) HP
5) Attack
6) Defense
7) Special Attack
8) Special Defense
9) Speed
Enter your choice: 3
Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed
Alomomola,8.02521%,144892,Water,None,165,75,80,40,45,65
Amoonguss,1.32496%,26867,Grass,Poison,114,85,70,85,80,30
Araquanid,2.27739%,133483,Water,Bug,68,70,92,50,132,42
Arcanine,0.10297%,8056,Fire,None,90,110,80,100,80,95
Arcanine-Hisui,0.10677%,26928,Fire,Rock,95,115,80,95,80,90
Armarouge,0.70990%,14624,Fire,Psychic,85,60,100,125,80,75
Azelf,0.03180%,6141,Psychic,None,75,125,70,125,70,115
Azumarill,0.31674%,25317,Water,Fairy,100,50,80,60,80,50
Barraskewda,1.41862%,29742,Water,None,61,123,60,60,50,136
Basculegion,0.06161%,9203,Water,Ghost,120,112,65,80,75,78
Basculegion-F,0.03964%,4789,Water,Ghost,120,92,65,100,75,78
Bellibolt,0.08699%,6285,Electric,None,109,64,91,103,83,45
Blaziken,1.99050%,61528,Fire,Fighting,80,120,70,110,70,80
Blissey,14.57042%,83168,Normal,None,255,10,10,75,135,55
Brambleghast,0.09320%,3996,Grass,Ghost,55,115,70,80,70,90
Breloom,0.04713%,13705,Grass,Fighting,60,130,80,60,60,70
And many more...
```

**c. Mencari nama pokemon tertentu**
```
         "3")
        echo -n "Enter Pokémon Name: "
        read search_name
        echo "$data" | awk -F',' -v name="$search_name" '
        NR==1 || index(tolower($1), tolower(name)) > 0'
        ;;
```
Menampilkan Enter Pokemon Name dan jawaban akan dimasukkan ke dalam variabel search_name. Lalu menggunakan awk "data" dan mencari nama pokemon dengan variabel tadi. Sehingga menghasilkan:
```
Answer: 3
Enter Pokémon Name: Iron
Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed
Iron Valiant,12.96719%,325396,Fairy,Fighting,74,130,90,120,60,116
Iron Leaves,0.03046%,3283,Grass,Psychic,90,130,88,70,108,104
Iron Treads,5.19971%,152983,Ground,Steel,90,112,120,72,70,106
Iron Moth,9.53296%,250109,Fire,Poison,80,70,60,140,110,110
Iron Crown,4.71712%,111658,Steel,Psychic,90,72,100,122,108,98
Iron Jugulis,0.13957%,6691,Dark,Flying,94,80,86,122,80,108
Iron Boulder,0.58363%,18544,Rock,Psychic,90,120,80,68,108,124
Iron Hands,0.77902%,38512,Fighting,Electric,154,140,108,50,68,50
```

**d. Mencari pokemon berdasarkan filter nama tipe pokemon**
```
        "4")
        echo -n "Enter Pokemon Type : "
        read type_poke
        echo "$data" | awk -F',' -v type="$type_poke" '
        NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)'
        ;;
```
Menampilkan Enter Pokemon Type dan jawaban akan dimasukkan ke dalam variabel type_poke. Lalu menggunakan awk "data" dan mencari pokemon dengan tipe dari isi varibel tersebut. Sehingga menghasilkan:
```
Answer: 4
Enter Pokemon Type : Dark
Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed
Wo-Chien,0.23694%,4529,Dark,Grass,85,85,100,95,135,70
Tyranitar,1.33768%,49808,Rock,Dark,100,134,110,95,100,61
Hydreigon,1.28620%,34067,Dark,Dragon,92,105,90,125,90,98
Roaring Moon,12.32447%,230323,Dragon,Dark,105,139,71,55,101,119
Incineroar,0.16340%,22526,Fire,Dark,95,115,90,80,90,60
Crawdaunt,0.04082%,9008,Water,Dark,63,120,85,90,55,55
Meowscarada,4.53179%,163897,Grass,Dark,76,110,70,81,70,123
Weavile,7.75603%,79409,Dark,Ice,70,120,65,45,85,125
Honchkrow,0.05233%,2917,Dark,Flying,100,125,52,105,52,71
Mandibuzz,1.54552%,18090,Dark,Flying,110,65,105,55,95,80
Anad many more...
```

**e. Error Handling**

Karena ini menggunakan case, maka *) di tiap case diberikan jawaban jika hal yang dipilih oleh pengguna tidak ada contohnya:
```
*)
        echo "The option you chose is not available. Please choose the thing that you need!"
*)
        echo "Please select a valid sorting option!"
```

**f. Help screen yang menarik**
```
"5")
        echo "⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
        echo "⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁"
        echo "⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀"
        echo "⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴"
        echo "⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿"
        echo "⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿"
        echo "⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿"
        echo "⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀⠀⠀⠠⣿⣿⣷⠀⢸⣿"
        echo "⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿"
        echo "⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹"

        echo "1. Pokemon Info -> Show you the highest pokemon usage and raw usage"
        echo "2. Sort Pokemon -> Sort the pokemon the way that you need"
        echo "3. Search Pokemon by Name -> Just like the way it's written on your screen"
        echo "4. Search Pokemon by type -> Just like the way it's written on your screen"
        ;;
```
Menggunakan ASCCI art di nternet dan menampilkan tampilan help screen yang akan memperjelas tujuan dari pengguna dan dapat memilih pilihan yang ingin digunakan. 

**REVISI**

Setelah demo, disarankan untuk merevisi input pada kode ini. Yang awalnya menggunakan case berbasis memilih pilihan, menjadi mengetik hal yang diinginkan contohnya mengetik -h / --help untuk menu help, -g / --grep untuk mencari pokemon dan lain sebagainya. Dengan revisi ini merubah hampir seluruh kode yang saya kerjakan.
Alhasil kode yang baru adalah :
```
#!/bin/bash

data=$(awk -F',' 'NR==0 {header=$0; next} {print $0} END {print header}' pokemon_usage.csv)

show_help() {
        echo "⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
        echo "⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁"
        echo "⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀"
        echo "⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴"
        echo "⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿"
        echo "⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿"
        echo "⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿"
        echo "⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀⠀⠀⠠⣿⣿⣷⠀⢸⣿"
        echo "⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿"
        echo "⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹"
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Show this help menu"
    echo "  -s, --sort <field>  Sort Pokémon data by a specific field"
    echo "  -n, --name <name>   Search Pokémon by name"
    echo "  -t, --type <type>   Search Pokémon by type"
    echo ""
    echo "Sorting Fields:"
echo "  usage, raw, name, hp, attack, defense, spatk, spdef, speed"
    exit 0
}

sort_pokemon() {
    case "$1" in
        usage) column=2; order="-nr";;
        raw) column=3; order="-nr";;
        name) column=1; order="";;
        hp) column=6; order="-nr";;
        attack) column=7; order="-nr";;
        defense) column=8; order="-nr";;
        spatk) column=9; order="-nr";;
        spdef) column=10; order="-nr";;
        speed) column=11; order="-nr";;
        *)
            echo "Invalid sorting field! Use one of: usage, raw, name, hp, attack, defense, spatk, spdef, speed"
            exit 1
            ;;
    esac

    echo "$data" | head -n 1
    echo "$data" | tail -n +2 | sort -t ',' $order -k"$column"
}

search_pokemon_by_name() {
    echo "$data" | awk -F',' -v name="$1" '
    NR==1 || index(tolower($1), tolower(name)) > 0'
}

search_pokemon_by_type() {
    echo "$data" | awk -F',' -v type="$1" '
    NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)'
}

while [[ "$#" -gt 0 ]]; do

    case "$1" in
        -h|--help) show_help ;;
        -s|--sort)
            shift
            sort_pokemon "$1"
            exit ;;
        -n|--name)
            shift
            search_pokemon_by_name "$1"
            exit ;;
        -t|--type)
            shift
            search_pokemon_by_type "$1"
            exit ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done

show_help
```
