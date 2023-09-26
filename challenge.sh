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
sudo auditctl -w /home/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /boot/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /etc/aaaaaaaa.txt -p wa -k mush 2>/dev/null
sudo auditctl -w /usr/aaaaaaaa.txt -p wa -k mush 2>/dev/null

for i in ${usuarios[@]}; do
	sudo auditctl -w /home/$i/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w "$desktop/aaaaaaaa.txt" -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$videos/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/Downloads/aaaaaaaa.txt -p wa -k mush 2>/dev/null
        sudo auditctl -w /home/$i/$documents/aaaaaaaa.txt -p wa -k mush 2>/dev/null
done


#IDENTIFICANDO PID E MATANDO ===========================|

#PidAnti=$(ps aux | grep -i challenge.sh | grep -i sudo | awk '{print $2}')
#echo "PidAnti: $PidAnti"
PidAnti2=$(ps aux | grep -i challenge.sh | grep -i bash | awk '{print $2}')
echo "PidAnti2: $PidAnti2"

while true; do
      PID=$(sudo ausearch -k mush | grep -i ppid | tail -n 1 | grep -o 'pid=[0-9]*' | awk -F'=' '{print $2}')
      for i in $PID; do
        if [ $i = "$PidAnti" ] || [ $i = "$PidAnti2" ]; then
                echo ""
        else
#	    sudo echo "" > /var/log/audit/audit.log
            echo "PID: $i"
	    kill -9 "$i" 2>/dev/null
            echo -e "\n\n$i: PID Cancelado!"
        fi
      done
   #sleep 0.2
  done
