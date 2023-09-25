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
if sudo apt-mark showinstall | grep -q auditd; then
        auditd=1
else
        auditd=0
        echo -e "auditd nao instalado!\n"
        sleep 2
        echo -e "Deseja instalar?\n"
        read -p "[S]im | [N]ao: " resp
        if [ $resp = "S" ] || [ $resp = "s" ]; then
                echo ""
                apt update -y
                apt-get install auditd -y
        else
                echo "Para continuar instale o software!"
                exit
        fi
fi

if sudo apt-mark showinstall | grep -q inotify-tools; then
	inotifyTools=1
else
	inotifyTools=0
	echo -e "inotify-tools não instalado!\n"
	sleep 2
	echo -e "Deseja instalar?\n"
	read -p "[S]im | [N]ão: " resp2
	if [ $resp2 = "S" ] || [ $resp2 = "s" ]; then
		echo ""
		apt update -y
		apt-get install inotify-tools -y
	else
		echo "Para continuar instale o software!"
		exit
	fi
fi

#=======================================================|



#CRIANDO ARQUIVOS HONEYFILE=============================|


usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)


for i in $usuarios; do

	if [ -d "/home/$i/Área de Trabalho" ]; then
		desktop="/home/$i/Área de Trabalho"
	else
		desktop="/home/$i/Desktop"
	fi

	if [ -d "/home/$i/Vídeos" ]; then
		videos="Vídeos"
	else
		videos="Videos"
	fi
	if [ -d "/home/$i/Documentos" ]; then 
		documents="Documentos"
	else
		documents="Documents"
	fi
done


echo -e "\nADICIONANDO REGRAS AUDITCTL..."
sudo auditctl -w /home/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /boot/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/ssh/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /usr/aaaaaaaa.txt -p wa -k mush 2>/dev/null

if [ -e /home/aaaaaaaa.dat ] || [ -e /boot/aaaaaaaa.txt ] || [ -e /etc/aaaaaaaa.txt ] || [ -e /etc/ssh/aaaaaaaa.txt ] || [ -e /usr/aaaaaaaa.txt ]; then
        echo ""
else
	echo -e "\nESPALHANDO HONEYFILES..."
	echo "~# sudo cp ./honeyfile.txt /home/aaaaaaaa.txt"
        sudo cp ./honeyfile.txt /home/aaaaaaaa.txt 2>/dev/null
        chmod 777 /home/aaaaaaaa.txt
	echo "~# sudo cp ./honeyfile.txt /boot/aaaaaaaa.txt"
        sudo cp ./honeyfile.txt /boot/aaaaaaaa.txt 2>/dev/null
        chmod 777 /boot/aaaaaaaa.txt
	echo "~# sudo cp ./honeyfile.txt /etc/aaaaaaaa.txt"
        sudo cp ./honeyfile.txt /etc/aaaaaaaa.txt 2>/dev/null
        chmod 777 /etc/aaaaaaaa.txt
	echo "~# sudo cp ./honeyfile.txt /etc/ssh/aaaaaaaa.txt"
        sudo cp ./honeyfile.txt /etc/ssh/aaaaaaaa.txt 2>/dev/null
        chmod 777 /etc/ssh/aaaaaaaa.txt
	echo "~# sudo cp ./honeyfile.txt /usr/aaaaaaaa.txt"
        sudo cp ./honeyfile.txt /usr/aaaaaaaa.txt 2>/dev/null
        chmod 777 /usr/aaaaaaaa.txt
fi

for i in ${usuarios[@]}; do
	
	echo -e "\nCRIANDO DIRETÓRIOS..."
	echo "~# sudo mkdir /home/$i/$documents"
	sudo -u $i mkdir /home/$i/$documents 2>/dev/null
	echo "~# sudo mkdir /home/$i/Downloads"
	sudo -u $i mkdir /home/$i/Downloads 2>/dev/null
	echo "~# sudo mkdir "$desktop""
	sudo -u $i mkdir "$desktop" 2>/dev/null
	echo "~# sudo mkdir /home/$i/$videos"
	sudo -u $i mkdir /home/$i/$videos 2>/dev/null

	echo -e "\nESPALHANDO HONEYFILES..."
#        sudo -u $i touch /home/$i/aaaaaaaa.txt 2>/dev/null
	echo "~# sudo cp ./honeyfile.txt /home/$i/aaaaaaaa.txt"
	sudo cp ./honeyfile.txt  /home/$i/aaaaaaaa.txt
#        sudo -u $i touch /home/$i/$documents/aaaaaaaa.txt 2>/dev/null
	echo "~# sudo cp ./honeyfile.txt /home/$i/$documents/aaaaaaaa.txt"
	sudo cp ./honeyfile.txt /home/$i/$documents/aaaaaaaa.txt
#        sudo -u $i touch /home/$i/Downloads/aaaaaaaa.txt 2>/dev/null
	echo "~# sudo cp ./honeyfile.txt /home/$i/Downloads/aaaaaaaa.txt"
	sudo cp ./honeyfile.txt /home/$i/Downloads/aaaaaaaa.txt
#        sudo -u $i touch "$desktop/aaaaaaa.txt" 2>/dev/null
	echo "~# sudo cp ./honeyfile.txt "$desktop/aaaaaaaa.txt""
	sudo cp ./honeyfile.txt "$desktop/aaaaaaaa.txt"
#        sudo -u $i touch /home/$i/$videos/aaaaaaaa.txt 2>/dev/null
	echo "~# sudo cp ./honeyfile.txt /home/$i/$videos/aaaaaaaa.txt"
	sudo cp ./honeyfile.txt /home/$i/$videos/aaaaaaaa.txt

	echo -e "\nMUDANDO PERMISSOES..."
        chmod 777 /home/$i/aaaaaaaa.txt 2>/dev/null
        chmod 777 /home/$i/$documents/aaaaaaaa.txt 2>/dev/null
        chmod 777 /home/$i/Downloads/aaaaaaaa.txt 2>/dev/null
        chmod 777 "$desktop/aaaaaaaa.txt" 2>/dev/null
        chmod 777 /home/$i/$videos/aaaaaaaa.txt 2>/dev/null


	echo -e "\nADICIONANDO REGRAS PARA AUDITCTL..."
        sudo auditctl -w /home/$i/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w "$desktop/aaaaaaaa.txt" -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$videos/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Downloads/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$documents/aaaaaaaa.txt -p wa -k mush 2>/dev/null
done
#=======================================================|


