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

# Soal 3

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
