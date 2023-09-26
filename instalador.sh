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

if sudo apt-mark showinstall | grep -q zip; then
	zip=1
else
	zip=0
	echo -e "zip nao instalado!\n"
	sleep 2
	echo -e "Deseja instalar?\n"
	read -p "[S]im | [N]ao: " resp3
	if [ $resp3 = "S" ] || [ $resp3 = "s" ]; then
		echo ""
		apt update -y
		apt-get install zip -y
	else
		echo "Para continuar instale o software!"
		exit
	fi
fi


#=======================================================|

#CHECANDO O ARQUIVOS====================================|
echo "CHECANDO ARQUIVOS..."
if [ -e ./challenge.sh ] || [ -e ./backup.sh ] || [ -e ./instalador.sh ] || [ -e ./honeyfile.zip ] || [ -e ./challenge.service ] || [ -e ./backup.service ] || [ -e ./flushlog.sh ] || [ -e ./flushlog.service ]; then
	echo "Ok."
else
	echo "FALTANDO ARQUIVOS CRUCIAIS..."
	echo "exit..."
	exit
fi

#=======================================================|

#DESCOMPACTANDO .ZIP====================================|

if [ -e ./honeyfile.txt ]; then
	echo ""
else
	echo -e "\n\nDESCOMPACTANDO .ZIP ..."
	echo "~# unzip ./honeyfile.zip"
	unzip ./honeyfile.zip
fi

#=======================================================|

#ALTERANDO PERMISSOES===================================|

echo "ALTERANDO PERMISSOES..."

echo "~# sudo -u root chmod 500 ./instalador.sh"
sudo -u root chmod 500 ./instalador.sh
echo "~# sudo chown root:root ./instalador.sh"
sudo chown root:root ./instalador.sh

echo "~# sudo -u root chmod 500 ./challenge"
sudo -u root chmod 500 ./challenge.sh
echo "~# sudo chown root:root ./challenge.sh"
sudo chown root:root ./challenge.sh

echo "~# sudo -u root chmod 500 ./backup.sh"
sudo -u root chmod 500 ./backup.sh
echo "~# sudo chown root:root ./backup.sh"
sudo chown root:root ./backup.sh

echo "~# sudo chown root:root ./honeyfile.zip"
sudo chown root:root ./honeyfile.zip
echo "~# sudo -u root chmod 444 ./honeyfile.zip"
sudo -u root chmod 444 ./honeyfile.zip

echo "~# sudo chown root:root ./honeyfile.txt"
sudo chown root:root ./honeyfile.txt
echo "~# sudo -u root chmod 444 ./honeyfile.txt"
sudo -u root chmod 444 ./honeyfile.txt

echo "~# sudo chown root:root ./flushlog.sh"
sudo chown root:root ./flushlog.sh
echo "~# sudo -u root chmod 500 ./flushlog.sh"
sudo -u root chmod 500 ./flushlog.sh

echo "~# sudo chown root:root ./flushlog.service"
sudo chown root:root ./flushlog.service
echo "~# sudo -u root chmod 777 ./flushlog.service"
sudo -u root chmod 777 ./flushlog.service

echo "~# sudo chown root:root ./challenge.service"
sudo chown root:root ./challenge.service
echo "~# sudo -u root chmod 777 ./challenge.service"
sudo -u root chmod 777 ./challenge.service

echo "~# sudo chown root:root ./backup.service"
sudo chown root:root ./backup.service
echo "~# sudo -u root chmod 777 ./backup.service"
sudo -u root chmod 777 ./backup.service

#=======================================================|

#MOVENDO ARQUIVOS=======================================|

echo -e "\nMOVENDO ARQUIVOS..."

echo "~# sudo cp ./instalador.sh /usr/sbin/"
sudo cp ./instalador.sh /usr/sbin/

echo "~# sudo cp ./instalador.service /etc/systemd/system/"
sudo cp ./instalador.service /etc/systemd/system/

echo "~# sudo cp ./challenge.sh /usr/sbin/"
sudo cp ./challenge.sh /usr/sbin/

echo "~# sudo cp ./challenge.service /etc/systemd/system/"
sudo cp ./challenge.service /etc/systemd/system/

echo "~# sudo cp ./backup.sh /usr/sbin/"
sudo cp ./backup.sh /usr/sbin/

echo "~# sudo cp ./backup.service /etc/systemd/system/"
sudo cp ./backup.service /etc/systemd/system/

echo "~# sudo cp ./flushlog.sh /usr/sbin/"
sudo cp ./flushlog.sh /usr/sbin/

echo "~# sudo cp ./flushlog.service /etc/systemd/system/"
sudo cp ./flushlog.service /etc/systemd/system/

#=======================================================|


#HABILITANDO .SERVICES==================================|
echo "HABILITANDO .SERVICES..."

echo "~# sudo systemctl daemon-reload"
sudo systemctl daemon-reload
echo "~# sudo systemctl enable challenge.service"
sudo systemctl enable challenge.service
echo "~# sudo systemctl enable backup.service"
sudo systemctl enable backup.service
echo "~# sudo systemctl enable flushlog.service"
sudo systemctl enable flushlog.service


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
sudo auditctl -w /usr/aaaaaaaa.txt -p wa -k mush 2>/dev/null

if [ -e /home/aaaaaaaa.dat ] || [ -e /boot/aaaaaaaa.txt ] || [ -e /etc/aaaaaaaa.txt ] || [ -e /usr/aaaaaaaa.txt ]; then
        echo ""
else
	echo -e "\nESPALHANDO HONEYFILES..."
	
	sudo touch /home/aaaaaaaa.txt
	if [ -e /home/aaaaaaaaa.txt ] || [ $(stat -c %s /home/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /home/aaaaaaaa.txt"
        	sudo cp ./honeyfile.txt /home/aaaaaaaa.txt 2>/dev/null
        	chmod 777 /home/aaaaaaaa.txt
	fi
	
	sudo touch /boot/aaaaaaaa.txt
	if [ -e /boot/aaaaaaaaa.txt ] || [ $(stat -c %s /boot/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /boot/aaaaaaaa.txt"
        	sudo cp ./honeyfile.txt /boot/aaaaaaaa.txt 2>/dev/null
        	chmod 777 /boot/aaaaaaaa.txt
	fi
	
	sudo touch /etc/aaaaaaaa.txt
	if [ -e /etc/aaaaaaaaa.txt ] || [ $(stat -c %s /etc/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /etc/aaaaaaaa.txt"
        	sudo cp ./honeyfile.txt /etc/aaaaaaaa.txt 2>/dev/null
        	chmod 777 /etc/aaaaaaaa.txt
	fi
	
	sudo touch /usr/aaaaaaaa.txt
	if [ -e /usr/aaaaaaaaa.txt ] || [ $(stat -c %s /usr/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /usr/aaaaaaaa.txt"
	        sudo cp ./honeyfile.txt /usr/aaaaaaaa.txt 2>/dev/null
	        chmod 777 /usr/aaaaaaaa.txt
	fi

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
	
	sudo touch /home/$i/aaaaaaaa.txt
	if [ -e /home/$i/aaaaaaaaa.txt ] || [ $(stat -c %s /home/$i/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /home/$i/aaaaaaaa.txt"
		sudo cp ./honeyfile.txt  /home/$i/aaaaaaaa.txt
	fi

	sudo touch /home/$i/$documents/aaaaaaaa.txt
	if [ -e /home/$i/$documents/aaaaaaaaa.txt ] || [ $(stat -c %s /home/$i/$documents/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /home/$i/$documents/aaaaaaaa.txt"
		sudo cp ./honeyfile.txt /home/$i/$documents/aaaaaaaa.txt
	fi

	sudo touch /home/$i/Downloads/aaaaaaaa.txt
	if [ -e /home/$i/Downloads/aaaaaaaaa.txt ] || [ $(stat -c %s /home/$i/Downloads/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /home/$i/Downloads/aaaaaaaa.txt"
		sudo cp ./honeyfile.txt /home/$i/Downloads/aaaaaaaa.txt
	fi

	sudo touch "$desktop/aaaaaaaa.txt"
	if [ -e "$desktop/aaaaaaaaa.txt" ] || [ $(stat -c %s "$desktop/aaaaaaaa.txt") != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt "$desktop/aaaaaaaa.txt""
		sudo cp ./honeyfile.txt "$desktop/aaaaaaaa.txt"
	fi

	sudo touch "/home/$i/$videos/aaaaaaaa.txt"
	if [ -e /home/$i/$videos/aaaaaaaaa.txt ] || [ $(stat -c %s /home/$i/$videos/aaaaaaaa.txt) != 578394351 ]; then
		echo "~# sudo cp ./honeyfile.txt /home/$i/$videos/aaaaaaaa.txt"
		sudo cp ./honeyfile.txt /home/$i/$videos/aaaaaaaa.txt
	fi
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
