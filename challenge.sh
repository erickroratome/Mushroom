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

echo -e "\nADICIONANDO REGRAS AUDITCTL..."
sudo auditctl -w /aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /home/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /boot/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /usr/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /backup/aaaaaaaa.txt -p wa -k mush 2>/dev/null

usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)

for i in ${usuarios[@]}; do
        sudo auditctl -w /home/$i/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w "$desktop/aaaaaaaa.txt" -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$videos/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Downloads/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$documents/aaaaaaaa.txt -p wa -k mush 2>/dev/null
done

#IDENTIFICANDO RANSOMWARE E MATANDO ===========================|

while true; do
      PID=$(sudo ausearch -k mush | grep -i ppid | tail -n 1 | grep -o 'pid=[0-9]*' | awk -F'=' '{print $2}')
      if [ -e "./SINALIZADOR.dat" ]; then
		nada="nada"
      else	
		for i in $PID; do
         	    echo "PID: $i"
		    kill -9 "$i" 2>/dev/null
	            echo -e "\n\n$i: PID Cancelado!"
	    	done
      fi
done
