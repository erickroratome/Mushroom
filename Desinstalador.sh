#!/bin/bash

nomearq="aaaaaaaa.txt"

echo -e "Voce deseja:\n 1 - Parar os serviços\n 2 - Desinstalar ferramenta\n"
read option
echo -e "\n--------------------------------------------"

if [ "$option" = "1" ]; then
    echo "Parando serviços selecionados."
    systemctl stop challenge.service
    systemctl stop backup.service
    systemctl stop flushlog.service
    systemctl stop instalador.service

    systemctl daemon-reload

elif [ "$option" = "2" ]; then
    echo -e "\nDESINSTALANDO HONEYFILES..."
    if [ -e /$nomearq ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] &&  [ -e /backup/$nomearq ]; then
        echo "Desinstalando Honeyfiles..."

        systemctl stop challenge.service
        systemctl stop backup.service
        systemctl stop flushlog.service
        systemctl stop instalador.service

        systemctl daemon-reload

        sudo rm /$nomearq
        sudo rm /home/$nomearq
        sudo rm /etc/$nomearq
        sudo rm /usr/$nomearq
        sudo rm -r /backup/$nomearq

        usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)
        for i in ${usuarios[@]}; do
            sudo -u $i rm /home/$i/$nomearq
            sudo -u $i rm /home/$i/$documents/$nomearq
            sudo -u $i rm /home/$i/Downloads/$nomearq
            sudo -u $i rm "$desktop/$nomearq"
            sudo -u $i rm /home/$i/$videos/$nomearq
        done
        echo -e "\n--------------------------------------------"
        echo "Honeyfiles desinstalados com sucesso!"
    else
        echo "Honeyfiles não encontrados ou não estão no tamanho esperado."
    fi
    systemctl daemon-reload
else
    echo "Opção inválida."
fi


