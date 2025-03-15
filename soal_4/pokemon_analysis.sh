#!/bin/bash

data=$(awk -F',' 'NR==1 {header=$0; next} {print $0} END {print header}' pokemon_usage.csv)

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

case "$amba" in
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

        "3")
	echo -n "Enter Pokémon Name: "
        read search_name
        echo "$data" | awk -F',' -v name="$search_name" '
        NR==1 || index(tolower($1), tolower(name)) > 0'
        ;;

	"4")
	echo -n "Enter Pokemon Type : "
	read type_poke
	echo "$data" | awk -F',' -v type="$type_poke" '
        NR==1 || tolower($4) == tolower(type) || tolower($5) == tolower(type)'
        ;;

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

	"6")
	exit
	;;

        *)
        echo "The option you chose is not available. Please choose the thing that you need!"
        ;;
    esac
continue
done
