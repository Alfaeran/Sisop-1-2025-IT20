#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

script_cpu_monitor="./script/cpu_monitor.sh"
script_ram_monitor="./script/frag_monitor.sh"

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
(crontab -l 2>/dev/null; echo "$interval bash $script_cpu_monitor") | crontab -
echo -e "${GREEN}CPU monitoring added!${NC}"
sleep 1
crontab.menu

}

add_ram_monitor() {
(crontab -l 2>/dev/null; echo "$interval bash $script_ram_monitor") | crontab -
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

