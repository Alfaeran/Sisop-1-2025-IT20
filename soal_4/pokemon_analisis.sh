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

