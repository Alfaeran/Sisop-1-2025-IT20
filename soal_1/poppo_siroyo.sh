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

case "$answer" in
"1")
awk '/Chris Hemsworth/ {n++}
END {print "Chris Hemsworth membaca sebanyak", n, "buku"}' reading_data.csv
echo "ga kayak kamu yang ga pernah baca buku"
;;
"2")
awk -F',' 'NR>1 && $8=="Tablet" {sum+=$6; count++}
END {printf "Rata-rata durasi membaca dengan Tablet adalah %.1f menit.\n", sum/count}' reading_data.csv
;;
"3")
awk -F',' 'NR>1 {if ($7>max) {max=$7; name=$2; book=$3}}
END {printf "Pembaca dengan rating tertinggi ialah %s - %s - %.lf\n", name, book, max}' reading_data.csv
;;
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
printf "Genre paling populer di Asia setelah tahun 2023 adalah: %s sebanyak %i buku\n", popular_genre, max_count}' reading_data.csv
;;
"5")
exit
;;
*)
echo "The thing that you asking is out of my capabalities. Pls, select the thing that you need"
;;
esac
continue
done
