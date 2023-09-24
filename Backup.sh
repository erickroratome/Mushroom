#!/bin/bash

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


#VERIFICANDO SOFTWARES INSTALADOS=======================|
if sudo apt-mark showinstall | grep -q inotify-tools; then
	inotifyTools=1
else
	inotifyTools=0
	echo -e "Inofy-tools nÃ£o instalado!\n para continuar instale:\n~# sudo apt install inotify-tools"
	sleep 2
	echo -e "Deseja instalar?\n"
	read -p "[S]im | [N]Ã£o: " resp
	if [ $resp = "S" ] || [ $resp = "s" ]; then
		echo ""
		apt update -y
		apt-get install inotify-tools -y
	else
		echo "Para continuar instale o software!"
		exit
	fi
fi
#=======================================================|


#CRIANDO BACKUP=========================================|


#Seu diretÃ³rio para backup:
backupDir="/backup/"


#DiretÃ³rio a ser monitorado:
monitorDir="/home/"
#read -p "Informe seu diretÃ³rio a ser monitorado: " monitorDir

if [ ! -d "$backupDir" ]; then
	mkdir -p "$backupDir"
	mkdir -p "$backupDir/notifyLog.txt"
fi
#=======================================================|


#MONITORANDO ALTERAÃ‡Ã•ES ALTERAÃ‡ÃƒO NOS ARQUIVOS==========|

maisAntigo=$(find "$backupDir" -type f -exec stat -c "%Y %n" {} + | grep -i "backup_" | sort -n | head -n 1 | awk '{print $2}') 2>/dev/null
echo "Mais antigo: $maisAntigo"
qntArq=$(find / -name "backup_*" -type f | wc -l)
if [ $qntArq -gt 4 ]; then
	rm -rf $maisAntigo
fi
data=$(date +"%Y-%m-%d_%H:%M:%S")
arqBackup="$backupDir/backup_$data.tar.gz"
tar -czvf "$arqBackup" "$monitorDir"/*
echo -e "\n$data\nBackup criado em $arqBackup\n" >>


while true; do
	echo $data $(inotifywait -r -e modify,create,delete,move "$monitorDir") >> "$backupDir/notifyLog.txt"
done
