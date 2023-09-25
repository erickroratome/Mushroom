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

#VERIFICANDO SOFTWARES INSTALADOS=======================|
if sudo apt-mark showinstall | grep -q auditd; then
        auditd=1
else
        auditd=0
        echo -e "auditd nÃ£o instalado!\n"
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
#=======================================================|

#CRIANDO ARQUIVOS HONEYFILE=============================|

sudo auditctl -w /home/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /boot/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/ssh/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /usr/##a -p wa -k mush 2>/dev/null

usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)
if [ -e /home/1@11a.dat ] || [ -e /boot/1@11a.dat ] || [ -e /etc/1@11a.dat ] || [ -e /etc/ssh/1@11a.dat ] || [ -e /usr/1@11a.dat ]; then
        echo ""
else
        touch /home/1@11a.dat 2>/dev/null
        chmod 777 /home/1@11a.dat
        touch /boot/1@11a.dat 2>/dev/null
        chmod 777 /boot/1@11a.dat
        touch /etc/1@11a.dat 2>/dev/null
        chmod 777 /etc/1@11a.dat
        touch /etc/ssh/1@11a.dat 2>/dev/null
        chmod 777 /etc/ssh/1@11a.dat
        touch /usr/1@11a.dat 2>/dev/null
        chmod 777 /usr/1@11a.dat
fi

for i in ${usuarios[@]}; do

	
	sudo -u $i mkdir /home/$i/Documents 2>/dev/null
	sudo -u $i mkdir /home/$i/Downloads 2>/dev/null
	sudo -u $i mkdir /home/$i/Desktop 2>/dev/null
	sudo -u $i mkdir /home/$i/Videos 2>/dev/null

        sudo -u $i touch /home/$i/1@11a.dat 2>/dev/null
        sudo -u $i touch /home/$i/Documents/1@11a.dat 2>/dev/null
        sudo -u $i touch /home/$i/Downloads/1@11a.dat 2>/dev/null
        sudo -u $i touch /home/$i/Desktop/1@11a.dat 2>/dev/null
        sudo -u $i touch /home/$i/Videos/1@11a.dat 2>/dev/null

        chmod 777 /home/$i/1@11a.dat 2>/dev/null
        chmod 777 /home/$i/Documents/1@11a.dat 2>/dev/null
        chmod 777 /home/$i/Downloads/1@11a.dat 2>/dev/null
        chmod 777 /home/$i/Desktop/1@11a.dat 2>/dev/null
        chmod 777 /home/$i/Videos/1@11a.dat 2>/dev/null


        sudo auditctl -w /home/$i/1@11a.dat -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Desktop/1@11a.dat -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Videos/1@11a.dat -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Downloads/1@11a.dat -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Documents/1@11a.dat -p wa -k mush 2>/dev/null
done
#=======================================================|

#IDENTIFICANDO PID E MATANDO ===========================|

#PidAnti=$(ps aux | grep -i challenge.sh | grep -i sudo | awk '{print $2}')
echo "PidAnti: $PidAnti"
PidAnti2=$(ps aux | grep -i challenge.sh | grep -i bash | awk '{print $2}')
echo "PidAnti2: $PidAnti2"

while true; do
      PID=$(sudo ausearch -k mush | grep -i ppid | tail -n 1 | grep -o 'pid=[0-9]*' | awk -F'=' '{print $2}')
      for i in $PID; do
        if [ $i = "$PidAnti" ] || [ $i = "$PidAnti2" ]; then
                echo ""
        else
	    sudo echo "" > /var/log/audit/audit.log
            echo "PID: $i"
	    kill -9 "$i" 2>/dev/null
            echo -e "\n\n$i: CPF Cancelado!"
        fi
      done
   sleep 0.2
  done
