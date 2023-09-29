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
    echo "~# systemctl stop challenge.service"
    systemctl stop challenge.service
    echo "~# systemctl stop backup.service"
    systemctl stop backup.service
    echo "~# systemctl stop flushlog.service"
    systemctl stop flushlog.service
    echo "~# systemctl stop instalador.service"
    systemctl stop instalador.service
    echo "~# systemctl daemon-reload"
    systemctl daemon-reload

elif [ "$option" = "2" ]; then
    echo -e "\nDESINSTALANDO HONEYFILES..."
    if [ -e /$nomearq ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] &&  [ -e /backup/$nomearq ]; then
        echo "Parando serviços selecionados."
        echo "~# systemctl stop challenge.service"
        systemctl stop challenge.service
        echo "~# systemctl stop backup.service"
        systemctl stop backup.service
        echo "~# systemctl stop flushlog.service"
        systemctl stop flushlog.service
        echo "~# systemctl stop instalador.service"
        systemctl stop instalador.service
        echo "~# systemctl daemon-reload"
        systemctl daemon-reload

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

        usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)
        for i in ${usuarios[@]}; do
            echo "~# sudo -u $i rm /home/$i/$nomearq"
            sudo -u $i rm /home/$i/$nomearq
            echo "~# sudo -u $i rm /home/$i/$documents/$nomearq"
            sudo -u $i rm /home/$i/$documents/$nomearq
            echo "~# sudo -u $i rm /home/$i/Downloads/$nomearq"
            sudo -u $i rm /home/$i/Downloads/$nomearq
            echo "~# sudo -u $i rm "$desktop/$nomearq""
            sudo -u $i rm "$desktop/$nomearq"
            echo "~# sudo -u $i rm /home/$i/$videos/$nomearq"
            sudo -u $i rm /home/$i/$videos/$nomearq
        done
        echo -e "\n--------------------------------------------"
        echo "Honeyfiles desinstalados com sucesso!"
    else
        echo "Honeyfiles não encontrados ou não estão no tamanho esperado."
    fi
    echo "~# systemctl daemon-reload"
    systemctl daemon-reload
else
    echo "Opção inválida."
fi


