#!/bin/bash
# Autores: 
# Erick Rorato
# Josué Suptitz
# github.com/erickroratome/Mushroom

echo -e "Anti-Ransomware - By:"
echo -e "\e[91m  _  __           _                                   \e[0m"
echo -e "\e[91m|  \/  |_   _ ___| |__  _ __ ___ ___  _ __ ___  ___ \e[0m"
echo -e "\e[91m| |\/| | | | / __| '_ \| '__/ _ \ _ \| '_ \` _ \/ __|\e[0m"
echo -e "\e[91m| |  | | |_| \__ \ | | | | | (_) (_) | | | | | \__ \\\ \e[0m"
echo -e "\e[91m|_|  |_|\__,_|___/_| |_|_|  \___/___/|_| |_| |_|___/\e[0m"


while true; do
	sleep 30
	echo "" > /var/log/audit/audit.log
	rm -rf /var/log/audit/audit.log.*
	sudo ./instalador.sh
done
