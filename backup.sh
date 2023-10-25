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


#DETECTAR ROOT===========================================|
valid=True
valid1=True
if [ $EUID != 0 ]; then
        valid=False
fi
if [ $USER != "root" ]; then
	valid1=False
fi

if [ $valid = False ] && [ $valid1 = False ]; then
	echo -e "\nPor favor execute com privilegios...\n"
	exit
fi
#=======================================================|


#CRIANDO BACKUP=========================================|


#Seu diretÃ³rio para backup:
backupDir="/zbackup/zmush"


#DiretÃ³rio a ser monitorado:
monitorDir="/home/"
#read -p "Informe seu diretÃ³rio a ser monitorado: " monitorDir

if [ ! -d "$backupDir" ]; then
	mkdir -p "$backupDir"
	touch "$backupDir/notifyLog.txt"
fi
#=======================================================|


#MONITORANDO ALTERAÃ‡Ã•ES NOS ARQUIVOS====================|

maisAntigo=$(find "$backupDir/" -type f -exec stat -c "%Y %n" {} + | grep -i "backup_" | sort -n | head -n 1 | awk '{print $2}') 2>/dev/null
echo "Mais antigo: $maisAntigo"
qntArq=$(find /zbackup/ -name "backup_*" -type f | wc -l)
if [ $qntArq -gt 3 ]; then
	rm -rf $maisAntigo
fi
data=$(date +"%Y-%m-%d_%H:%M:%S")
arqBackup="$backupDir/backup_$data.tar.gz"
tar -czvf "$arqBackup" "$monitorDir"/*
echo "~# chmod 000 "arqBackup""
chmod 000 "$arqBackup"
echo -e "\n$data\nBackup criado em $arqBackup:\n" >> $backupDir/notifyLog.txt


while true; do
	data=$(date +"%Y-%m-%d_%H:%M:%S")
	echo $data $(inotifywait -r -e modify,create,delete,move "$monitorDir") >> "$backupDir/notifyLog.txt"
done
