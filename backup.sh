#!/bin/bash

echo "By:"
echo "     _                     _      _     "
echo "    | | ___  ___  ___ _ __(_) ___| | __ "
echo " _  | |/ _ \/ __|/ _ \ '__| |/ __| |/ / "
echo "| |_| | (_) \__ \  __/ |  | | (__|   <  "
echo " \___/ \___/|___/\___|_|  |_|\___|_|\_\ "
echo ""


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
	echo -e "\nPor favor execute como root...\n"
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


#while true; do
#	data=$(date +"%Y-%m-%d_%H:%M:%S")
#	echo $data $(inotifywait -r -e modify,create,delete,move "$monitorDir") >> "$backupDir/notifyLog.txt"
#done
