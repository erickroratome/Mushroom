nomearq="aaaaaaaa.txt"

echo -e "\nPARANDO SERVICES..."
systemctl stop challenge.service
backup.service
flushlog.service
instalador.service
echo -e "\n--------------------------------------------"

echo -e "\nDESINSTALANDO HONEYFILES..."
if [ -e /$nomearq ] && [ $(stat -c %s /$nomearq) = $tamanhoHoneyfile ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] && [ $(stat -c %s /home/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /etc/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /usr/$nomearq) = $tamanhoHoneyfile ] && [ -e /backup/$nomearq ] && [ $(stat -c %s /backup/$nomearq) = $tamanhoHoneyfile ]; then
    echo "Desinstalando Honeyfiles..."

    
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
