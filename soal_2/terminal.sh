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
