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


nomearq="aaaaaaaa.txt"
echo -e "Voce deseja:\n 1 - Parar os serviços\n 2 - Desinstalar ferramenta\n"
read option
echo -e "\n--------------------------------------------"

if [ "$option" = "1" ]; then
    echo "Parando serviços selecionados."
    echo "~# systemctl stop mushroom.service"
    systemctl stop mushroom.service
    echo "~# systemctl stop backup.service"
    systemctl stop backup.service
    echo "~# systemctl stop flushlog.service"
    systemctl stop flushlog.service
    echo "~# systemctl stop instalador.service"
    systemctl stop instalador.service
    echo "~# systemctl daemon-reload"
    systemctl daemon-reload

elif [ "$option" = "2" ]; then
    echo "Parando serviços selecionados."
    echo "~# systemctl stop mushroom.service"
    systemctl stop mushroom.service
    echo "~# systemctl stop backup.service"
    systemctl stop backup.service
    echo "~# systemctl stop flushlog.service"
    systemctl stop flushlog.service
    echo "~# systemctl stop instalador.service"
    systemctl stop instalador.service

    echo "~# systemctl disable mushroom.service"
    systemctl disable mushroom.service
    echo "~# systemctl disable backup.service"
    systemctl disable backup.service
    echo "~# systemctl disable flushlog.service"
    systemctl disable flushlog.service
    echo "~# systemctl disable instalador.service"
    systemctl disable instalador.service
        
    echo -e "\nDESINSTALANDO HONEYFILES..."
    if [ -e /$nomearq ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] &&  [ -e /backup/$nomearq ]; then        
        echo "~# sudo rm -rf /$nomearq"
        sudo rm -rf /$nomearq
        echo "~# sudo rm -rf /home/$nomearq"
        sudo rm -rf /home/$nomearq
        echo "~# sudo rm -rf /etc/$nomearq"
        sudo rm -rf /etc/$nomearq
        echo "~# sudo rm -rf /usr/$nomearq"
        sudo rm -rf /usr/$nomearq
        echo "~# sudo rm -rf /backup/$nomearq"
        sudo rm -rf /backup/$nomearq
    fi

    usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)
    for i in ${usuarios[@]}; do
        echo "~# rm -rf /home/$i/$nomearq"
        rm -rf /home/$i/$nomearq
        echo "~# rm -rf /home/$i/$documents/$nomearq"
        rm -rf /home/$i/$documents/$nomearq
        echo "~# rm -rf /home/$i/Downloads/$nomearq"
        rm -rf /home/$i/Downloads/$nomearq
        echo "~# rm -rf "$desktop/$nomearq""
        rm -rf "$desktop/$nomearq"
        echo "~# rm -rf /home/$i/$videos/$nomearq"
        rm -rf /home/$i/$videos/$nomearq
    done

    localArqs=$(find /home -name "$nomearq" 2>/dev/null)
    for i in $localArqs; do
        echo "~# rm -rf $i"
        rm -rf $i
    done
        
    echo -e "\n--------------------------------------------"
    echo "Honeyfiles desinstalados com sucesso!"
    echo -e "\nRemovendo .services"
    echo "~# rm -rf /etc/systemd/system/challange.service"
    rm -rf /etc/systemd/system/challange.service
    echo "~# /etc/systemd/system/backup.service"
    rm -rf /etc/systemd/system/backup.service
    echo "~# /etc/systemd/system/flushlog.service"
    rm -rf /etc/systemd/system/flushlog.service
    echo "~# /etc/systemd/system/instalador.service"
    rm -rf /etc/systemd/system/instalador.service

    echo -e "\nRemovendo scripts"
    echo "~# rm -rf /usr/sbin/challange.sh"
    rm -rf /usr/sbin/challange.sh
    echo "~# rm -rf /usr/sbin/backup.sh"
    rm -rf /usr/sbin/backup.sh
    echo "~# rm -rf /usr/sbin/flushlog.sh"
    rm -rf /usr/sbin/flushlog.sh
    echo "~# rm -rf /usr/sbin/instalador.sh"
    rm -rf /usr/sbin/instalador.sh

    echo "~# systemctl daemon-reload"
    systemctl daemon-reload

    echo -e "\n\nDesintalação concluida!\n"

    echo -e "\nForam instaladas as depencias:\nwget\ninotify-tools\nzip\nauditd\nPara desinstalar:\n~$ sudo apt remove dependecia\n"
    
else
    echo "Opção inválida."
fi


