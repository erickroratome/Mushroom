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
        read -p "[S]im | [N]Ã£o: " resp
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

sudo auditctl -w /home/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /boot/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/ssh/##a -p wa -k mush 2>/dev/null
sudo auditctl -w /usr/##a -p wa -k mush 2>/dev/null

#CRIANDO ARQUIVOS HONEYFILE=============================|


#LIMPANDO LOG===========================================|

#sudo systemctl stop auditd.service
#sudo systemctl start auditd.service

#=======================================================|


usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)
if [ -e /home/##a ] || [ -e /boot/##a ] || [ -e /etc/##a ] || [ -e /etc/ssh/##a ] || [ -e /usr/##a ]; then
        echo ""
else
        touch /home/##a 2>/dev/null
        chmod 777 /home/##a
        touch /boot/##a 2>/dev/null
        chmod 777 /boot/##a
        touch /etc/##a 2>/dev/null
        chmod 777 /etc/##a
        touch /etc/ssh/##a 2>/dev/null
        chmod 777 /etc/ssh/##a
        touch /usr/##a 2>/dev/null
        chmod 777 /usr/##a
fi

for i in ${usuarios[@]}; do

	
	sudo -u $i mkdir /home/$i/Documents 2>/dev/null
	sudo -u $i mkdir /home/$i/Downloads 2>/dev/null
	sudo -u $i mkdir /home/$i/Desktop 2>/dev/null
	sudo -u $i mkdir /home/$i/Videos 2>/dev/null

        sudo -u $i touch /home/$i/##a 2>/dev/null
        sudo -u $i touch /home/$i/Documents/##a 2>/dev/null
        sudo -u $i touch /home/$i/Downloads/##a 2>/dev/null
        sudo -u $i touch /home/$i/Desktop/##a 2>/dev/null
        sudo -u $i touch /home/$i/Videos/##a 2>/dev/null

        chmod 777 /home/$i/##a 2>/dev/null
        chmod 777 /home/$i/Documents/##a 2>/dev/null
        chmod 777 /home/$i/Downloads/##a 2>/dev/null
        chmod 777 /home/$i/Desktop/##a 2>/dev/null
        chmod 777 /home/$i/Videos/##a 2>/dev/null


        sudo auditctl -w /home/$i/##a -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Desktop/##a -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Videos/##a -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Downloads/##a -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Documents/##a -p wa -k mush 2>/dev/null
done
#=======================================================|

PidAnti=$(ps aux | grep -i challenge.sh | grep -i sudo | awk '{print $2}')
echo "PidAnti: $PidAnti"
PidAnti2=$(ps aux | grep -i challenge.sh | grep -i bash | awk '{print $2}')
echo "PidAnti2: $PidAnti2"
#sleep 100000000

#arqMonitorados=(
#  "/boot/##a"
#  "/home/##a"
#  "/etc/##a"
#  "/etc/ssh/#aa"
#  "/usr/##a"
#)

#for usuario in $usuarios; do
#    arqMonitorados+=("/home/$usuario/##a")
#done

while true; do
#  for arquivo in "${arqMonitorados[@]}"; do
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
#done
