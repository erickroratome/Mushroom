#!/bin/bash
# Autores: 
# Erick Rorato
# Josué Suptitz
# github.com/erickroratome/Mushroom

echo -e "Anti-Ransomware - By:"
echo -e "\e[91m  _  __           _                                   \e[0m"
echo -e "\e[91m|  \/  |_   _ ___| |__  _ __ ___ ___  _ __ ___  ___ \e[0m"
echo -e "\e[91m| |\/| | | | / __| '_ \| '__/ _ \ _ \| '_ \` _ \/ __|\e[0m"
echo -e "\e[91m| |  | | |_| \__ \ | | | | | (_) (_) | | | | | \__ \\\ \e[0m"
echo -e "\e[91m|_|  |_|\__,_|___/_| |_|_|  \___/___/|_| |_| |_|___/\e[0m"

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
onde=$(pwd)
if [ ! -e "$onde/instalador.sh" ]; then
	echo "Execute no mesmo diretório do instalador..."
 	exit
fi

#=======================================================|
#VERIFICANDO SOFTWARES INSTALADOS=======================|
echo -e "\nCHECANDO SOFTWARES INSTALADOS..."
if sudo apt-mark showinstall | grep -q auditd; then
	echo "[OK] auditd"
else
        echo -e "\n\nauditd nao instalado!\n"
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
 	echo "[OK] inotify-tools"
else
	echo -e "\n\ninotify-tools não instalado!\n"
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
#
if sudo apt-mark showinstall | grep -q zip; then
	echo "[OK] zip"
else
	echo -e "\n\nzip nao instalado!\n"
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
#
if sudo apt-mark showinstall | grep -q wget; then
	echo "[OK] wget"
else
	echo -e "\n\nwget nao instalado!\n"
	sleep 2
	echo -e "Deseja instalar?\n"
	read -p "[S]im | [N]ao: " resp3
	if [ $resp3 = "S" ] || [ $resp3 = "s" ]; then
		echo ""
		apt update -y
		apt-get install wget -y
	else
		echo "Para continuar instale o software!"
		exit
	fi
fi


#=======================================================|

#CHECANDO O ARQUIVOS====================================|
echo -e "\nCHECANDO ARQUIVOS..."

url="https://github.com/erickroratome/Mushroom/"
checkarq() {
	if [ -e ./mushroom.sh ]; then
		echo "[OK] mushroom.sh"
	else
		echo "[FAIL] mushroom.sh"
      		echo "~# wget "$url/raw/main/mushroom.sh""
		wget "$url/raw/main/mushroom.sh"
  		echo ""
	fi
	#
	if [ -e ./backup.sh ]; then
		echo "[OK] backup.sh"
	else
		echo "[FAIL] backup.sh"
      		echo "~# wget "$url/raw/main/backup.sh""
		wget "$url/raw/main/backup.sh"
  		echo ""
	fi
	#
	if [ -e ./flushlog.sh ]; then
		echo "[OK] flushloge.sh"
	else
		echo "[FAIL] flushlog.sh"
      		echo "~# wget "$url/raw/main/flushlog.sh""
		wget "$url/raw/main/flushlog.sh"
    		echo ""
	fi
	#
	if [ -e ./honeyfile.zip ]; then
		echo "[OK] honeyfile.zip"
	else
		echo "[FAIL] honeyfile.zip"
      		echo "~# wget "$url/raw/main/honeyfile.zip""
		wget "$url/raw/main/honeyfile.zip"
    		echo ""
	fi
	#
	if [ -e ./instalador.sh ]; then
		echo "[OK] instalador.sh"
	else
		echo "[FAIL] instalador.sh"
      		echo "~# wget "$url/raw/main/instalador.sh""
		wget "$url/raw/main/instalador.sh"
    		echo ""
	fi
	#
	if [ -e /etc/systemd/system/mushroom.service ] || [ -e ./mushroom.service ]; then
		echo "[OK] mushroom.service"
	else
		echo "[FAIL] mushroom.service"
      		echo "~# wget "$url/raw/main/mushroom.service""
		wget "$url/raw/main/mushroom.service"
    		echo ""
	fi
	#
	if [ -e /etc/systemd/system/backup.service ] || [ -e ./backup.service ]; then
		echo "[OK] backup.service"
	else
		echo "[FAIL] backup.service"
      		echo "~# wget "$url/raw/main/backup.service""
		wget "$url/raw/main/backup.service"
    		echo ""
	fi
	#
	if [ -e /etc/systemd/system/flushlog.service ] || [ -e ./flushlog.service ]; then
		echo "[OK] flushlog.service"
	else
		echo "[FAIL] flushlog.service"
      		echo "~# wget "$url/raw/main/flushlog.service""
		wget "$url/raw/main/flushlog.service"
    		echo ""
	fi
	#
	if [ -e /etc/systemd/system/instalador.service ] || [ -e ./instalador.service ]; then
		echo "[OK] instalador.service"
	else
		echo "[FAIL] instalador.service"
    		echo "~# wget "$url/raw/main/instalador.service""
		wget "$url/raw/main/instalador.service"
    		echo ""
	fi
}
checkarq


if [ -e ./mushroom.sh ] && [ -e ./backup.sh ] && [ -e ./instalador.sh ] && [ -e ./honeyfile.zip ] && [ -e ./mushroom.service ] && [ -e ./backup.service ] && [ -e ./flushlog.sh ] && [ -e ./flushlog.service ]; then
	nada="nada"
else
	if [ -e /etc/systemd/system/mushroom.service ] && [ -e /etc/systemd/system/backup.service ] && [ -e /etc/systemd/system/flushlog.service ]; then
		echo "OK."
	else
		echo -e"\n\n\nFALTANDO ARQUIVOS CRUCIAIS PARA O FUNCIONAMENTO DO SISTEMA...\n"
  		echo -e"\n\n\n$(date) FALTANDO ARQUIVOS CRUCIAIS PARA O FUNCIONAMENTO DO SISTEMA...\n" >> ./mushlog.txt
		exit
	fi
fi

#=======================================================|

#DESCOMPACTANDO .ZIP====================================|
tamanhoHoneyfile=123855156
tamanhoHoneyfileLess=19051201

descompactar() {
	if [ -e ./honeyfile.txt ] && [ $(stat -c %s ./honeyfile.txt) = $tamanhoHoneyfile ]; then
		nada="nada"
  	elif [ -e ./honeyfile-less.txt ] && [ $(stat -c %s ./honeyfile-less.txt) = "$tamanhoHoneyfileLess" ]; then
		nada="nada"
	else
		if [ -e ./honeyfile.zip ] && [ $(stat -c %s ./honeyfile.zip) = 496390 ]; then
			echo ""
		else
			if [ -e ./honeyfile.zip ]; then
				rm -rf ./honeyfile.zip
			fi		
			wget https://github.com/erickroratome/Mushroom/raw/main/honeyfile.zip
			sudo -u root chmod 444 ./honeyfile.zip
		fi
		echo -e "\n\nDESCOMPACTANDO .ZIP ..."
		echo "~# unzip -o ./honeyfile.zip"
		unzip -o ./honeyfile.zip
	fi
}
descompactar


#=======================================================|

#ALTERANDO PERMISSOES===================================|

echo -e "\nALTERANDO PERMISSOES..."

echo "~# sudo chown root:root ./instalador.sh"
sudo chown root:root ./instalador.sh
echo "~# sudo -u root chmod 500 ./instalador.sh"
sudo -u root chmod 500 ./instalador.sh

echo "~# sudo chown root:root ./mushroom.sh"
sudo chown root:root ./mushroom.sh
echo "~# sudo -u root chmod 500 ./mushroom"
sudo -u root chmod 500 ./mushroom.sh

echo "~# sudo chown root:root ./backup.sh"
sudo chown root:root ./backup.sh
echo "~# sudo -u root chmod 500 ./backup.sh"
sudo -u root chmod 500 ./backup.sh

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


if [ ! -e ./flushlog.service ]; then
	echo "~# sudo chown root:root /etc/systemd/system/flushlog.service"
	sudo chown root:root /etc/systemd/system/flushlog.service
	echo "~# sudo -u root chmod 777 /etc/systemd/system/flushlog.service"
	sudo -u root chmod 777 /etc/systemd/system/flushlog.service
else
	echo "~# sudo chown root:root ./flushlog.service"
	sudo chown root:root ./flushlog.service
	echo "~# sudo -u root chmod 777 ./flushlog.service"
	sudo -u root chmod 777 ./flushlog.service
fi
#
if [ ! -e ./mushroom.service ]; then
	echo "~# sudo chown root:root /etc/systemd/system/mushroom.service"
	sudo chown root:root /etc/systemd/system/mushroom.service
	echo "~# sudo -u root chmod 777 /etc/systemd/system/mushroom.service"
	sudo -u root chmod 777 /etc/systemd/system/mushroom.service
else
	echo "~# sudo chown root:root ./mushroom.service"
	sudo chown root:root ./mushroom.service
	echo "~# sudo -u root chmod 777 ./mushroom.service"
	sudo -u root chmod 777 ./mushroom.service
fi
#
if [ ! -e ./mushroom.service ]; then
	echo "~# sudo chown root:root /etc/systemd/system/backup.service"
	sudo chown root:root /etc/systemd/system/backup.service
	echo "~# sudo -u root chmod 777 /etc/systemd/system/backup.service"
	sudo -u root chmod 777 /etc/systemd/system/backup.service
else
	echo "~# sudo chown root:root ./backup.service"
	sudo chown root:root ./backup.service
	echo "~# sudo -u root chmod 777 ./backup.service"
	sudo -u root chmod 777 ./backup.service
fi
#
if [ ! -e ./mushroom.service ]; then
	echo "~# sudo chown root:root /etc/systemd/system/instalador.service"
	sudo chown root:root /etc/systemd/system/instalador.service
	echo "~# sudo -u root chmod 777 /etc/systemd/system/instalador.service"
	sudo -u root chmod 777 /etc/systemd/system/instalador.service
else
	echo "~# sudo chown root:root ./instalador.service"
	sudo chown root:root ./instalador.service
	echo "~# sudo -u root chmod 777 ./instalador.service"
	sudo -u root chmod 777 ./instalador.service
fi
#=======================================================|


#MOVENDO ARQUIVOS=======================================|
echo -e "\nMOVENDO ARQUIVOS..."

echo "~# cp ./instalador.sh /usr/sbin/"
cp ./instalador.sh /usr/sbin/

echo "~# cp ./instalador.service /etc/systemd/system/"
cp ./instalador.service /etc/systemd/system/

echo "~# cp ./mushroom.sh /usr/sbin/"
cp ./mushroom.sh /usr/sbin/

echo "~# cp ./mushroom.service /etc/systemd/system/"
cp ./mushroom.service /etc/systemd/system/

echo "~# cp ./backup.sh /usr/sbin/"
cp ./backup.sh /usr/sbin/

echo "~# cp ./backup.service /etc/systemd/system/"
cp ./backup.service /etc/systemd/system/

echo "~# cp ./flushlog.sh /usr/sbin/"
cp ./flushlog.sh /usr/sbin/

echo "~# cp ./flushlog.service /etc/systemd/system/"
cp ./flushlog.service /etc/systemd/system/

#=======================================================|


#HABILITANDO .SERVICES==================================|
echo -e "\nHABILITANDO .SERVICES..."

echo "~# sudo systemctl daemon-reload"
sudo systemctl daemon-reload
echo "~# sudo systemctl enable mushroom.service"
sudo systemctl enable mushroom.service
echo "~# sudo systemctl enable backup.service"
sudo systemctl enable backup.service
echo "~# sudo systemctl enable flushlog.service"
sudo systemctl enable flushlog.service
echo "~# sudo systemctl enable instalador.service"
sudo systemctl enable instalador.service
echo "~# sudo systemctl enable auditd.service"
sudo systemctl enable auditd.service

#CRIANDO ARQUIVOS HONEYFILE DO USUARIO=============================|
nomearq="aaaaaaaa.txt"
usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)

for i in $usuarios; do
	if [ ! -d /home/$i ]; then
 		nada="nada"
   	else
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
  	fi
done

echo -e "\nADICIONANDO REGRAS AUDITCTL..."
echo "~# sudo auditctl -w /$nomearq -p wa -k mush"
sudo auditctl -w /$nomearq -p wa -k mush 2>/dev/null
echo "~# sudo auditctl -w /home/$nomearq -p wa -k mush"
sudo auditctl -w /home/$nomearq -p wa -k mush 2>/dev/null
echo "~# sudo auditctl -w /etc/$nomearq -p wa -k mush"
sudo auditctl -w /etc/$nomearq -p wa -k mush 2>/dev/null
echo "~# sudo auditctl -w /usr/$nomearq -p wa -k mush"
sudo auditctl -w /usr/$nomearq -p wa -k mush 2>/dev/null
echo "~# sudo auditctl -w /backup/$nomearq -p wa -k mush"
sudo auditctl -w /backup/$nomearq -p wa -k mush 2>/dev/null
echo "~# sudo auditctl -w /root/$nomearq -p wa -k mush"
sudo auditctl -w /root/$nomearq -p wa -k mush 2>/dev/null

if [ -e /root/$nomearq ] && [ $(stat -c %s /root/$nomearq) = $tamanhoHoneyfile ] && [ -e /$nomearq ] && [ $(stat -c %s /$nomearq) = $tamanhoHoneyfile ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] && [ $(stat -c %s /home/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /etc/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /usr/$nomearq) = $tamanhoHoneyfile ] && [ -e /backup/$nomearq ] && [ $(stat -c %s /backup/$nomearq) = $tamanhoHoneyfile ]; then
        echo ""
else
	echo -e "\nESPALHANDO HONEYFILES NO SISTEMA..."
	
	touch ./SINALIZADOR.dat
	sudo touch /root/$nomearq
 	if [ $(stat -c %s /root/$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /root/$nomearq"
        	cp ./honeyfile.txt /root/$nomearq 2>/dev/null
        	chmod 777 /root/$nomearq
	fi
 	sudo touch /$nomearq
 	if [ $(stat -c %s /$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /$nomearq"
        	cp ./honeyfile.txt /$nomearq 2>/dev/null
        	chmod 777 /$nomearq
	fi
 	sudo touch /home/$nomearq
	if [ $(stat -c %s /home/$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /home/$nomearq"
        	cp ./honeyfile.txt /home/$nomearq 2>/dev/null
        	chmod 777 /home/$nomearq
	fi
	sudo touch /etc/$nomearq
	if [ $(stat -c %s /etc/$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /etc/$nomearq"
        	cp ./honeyfile.txt /etc/$nomearq 2>/dev/null
        	chmod 777 /etc/$nomearq
	fi
	
	sudo touch /usr/$nomearq
	if [ $(stat -c %s /usr/$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /usr/$nomearq"
	        cp ./honeyfile.txt /usr/$nomearq 2>/dev/null
	        chmod 777 /usr/$nomearq
	fi
 
  	mkdir /backup 2>/dev/null
 	sudo touch /backup/$nomearq
	if [ $(stat -c %s /backup/$nomearq) != $tamanhoHoneyfile ]; then
		echo "~# cp ./honeyfile.txt /backup/$nomearq"
	        cp ./honeyfile.txt /backup/$nomearq 2>/dev/null
	        chmod 777 /backup/$nomearq
	fi
	rm -rf ./SINALIZADOR.dat

fi

echo -e "\nCHECANDO DIRETÓRIOS DO USUARIO..."
for i in ${usuarios[@]}; do
	if [ ! -d /home/$i ]; then
 		nada="nada"
   	else
		if [ ! -d "/home/$i/$documents" ]; then
		    touch ./SINALIZADOR.dat
		    echo "~# sudo mkdir /home/$i/$documents"
		    sudo -u $i mkdir "/home/$i/$documents"
		    rm -rf ./SINALIZADOR.dat
	     	else
	      	    echo "[OK] "/home/$i/$documents""
		fi
		
		if [ ! -d "/home/$i/Downloads" ]; then
		    touch ./SINALIZADOR.dat
		    echo "~# sudo mkdir /home/$i/Downloads"
		    sudo -u $i mkdir "/home/$i/Downloads"
		    rm -rf ./SINALIZADOR.dat
	     	else
	      		echo "[OK] "/home/$i/Downloads""
		fi
		
		if [ ! -d "$desktop" ]; then
		    touch ./SINALIZADOR.dat
		    echo "~# sudo mkdir "$desktop""
		    sudo -u $i mkdir "$desktop"
		    rm -rf ./SINALIZADOR.dat
	     	else
	      		echo "[OK] "$desktop""
		fi
		
		if [ ! -d "/home/$i/$videos" ]; then
		    touch ./SINALIZADOR.dat
		    echo "~# sudo mkdir /home/$i/$videos"
		    sudo -u $i mkdir "/home/$i/$videos"
		    rm -rf ./SINALIZADOR.dat
	     	else
	      		echo "[OK] "/home/$i/$videos""
		fi
	
		echo -e "\nESPALHANDO HONEYFILES NO HOME USUARIO..."
		sudo touch /home/$i/$nomearq
		if [ $(stat -c %s /home/$i/$nomearq) != $tamanhoHoneyfile ]; then
	 		touch ./SINALIZADOR.dat
			echo "~# cp ./honeyfile.txt /home/$i/$nomearq"
			cp ./honeyfile.txt  /home/$i/$nomearq
	  		rm -rf ./SINALIZADOR.dat
	 	fi
	
		sudo touch /home/$i/$documents/$nomearq
		if [ $(stat -c %s /home/$i/$documents/$nomearq) != $tamanhoHoneyfile ]; then
	 		touch ./SINALIZADOR.dat
			echo "~# cp ./honeyfile.txt /home/$i/$documents/$nomearq"
			cp ./honeyfile.txt /home/$i/$documents/$nomearq
	  		rm -rf ./SINALIZADOR.dat
		fi
	
		sudo touch /home/$i/Downloads/$nomearq
		if [ $(stat -c %s /home/$i/Downloads/$nomearq) != $tamanhoHoneyfile ]; then
	 		touch ./SINALIZADOR.dat
			echo "~# cp ./honeyfile.txt /home/$i/Downloads/$nomearq"
			cp ./honeyfile.txt /home/$i/Downloads/$nomearq
	  		rm -rf ./SINALIZADOR.dat
		fi
	
		sudo touch "$desktop/$nomearq"
		if [ $(stat -c %s "$desktop/$nomearq") != $tamanhoHoneyfile ]; then
	 		touch ./SINALIZADOR.dat
			echo "~# cp ./honeyfile.txt "$desktop/$nomearq""
			cp ./honeyfile.txt "$desktop/$nomearq"
	  		rm -rf ./SINALIZADOR.dat
		fi
	
		sudo touch "/home/$i/$videos/$nomearq"
		if [ $(stat -c %s /home/$i/$videos/$nomearq) != $tamanhoHoneyfile ]; then
	 		touch ./SINALIZADOR.dat
			echo "~# cp ./honeyfile.txt /home/$i/$videos/$nomearq"
			cp ./honeyfile.txt /home/$i/$videos/$nomearq
	  		rm -rf ./SINALIZADOR.dat
		fi
		rm -rf ./SINALIZADOR.dat 2>/dev/null
		echo -e "\nMUDANDO PERMISSOES..."
	 	touch ./SINALIZADOR.dat
	  	echo "~# chmod 777 /home/$i/$nomearq"
		chmod 777 /home/$i/$nomearq 2>/dev/null
	 	echo "~# chmod 777 /home/$i/$documents/$nomearq"
	        chmod 777 /home/$i/$documents/$nomearq 2>/dev/null
		echo "~# chmod 777 /home/$i/Downloads/$nomearq"
	        chmod 777 /home/$i/Downloads/$nomearq 2>/dev/null
		echo "~# chmod 777 "$desktop/$nomearq""
	        chmod 777 "$desktop/$nomearq" 2>/dev/null
		echo "~# chmod 777 /home/$i/$videos/$nomearq"
	        chmod 777 /home/$i/$videos/$nomearq 2>/dev/null
		
	
		echo -e "\nADICIONANDO REGRAS PARA AUDITCTL..."
	 	echo "~# sudo auditctl -w /home/$i/$nomearq -p wa -k mush"
	        sudo auditctl -w /home/$i/$nomearq -p wa -k mush 2>/dev/null
		echo "~# sudo auditctl -w "$desktop/$nomearq" -p wa -k mush"
	        sudo auditctl -w "$desktop/$nomearq" -p wa -k mush 2>/dev/null
		echo "~# sudo auditctl -w /home/$i/$videos/$nomearq -p wa -k mush"
	        sudo auditctl -w /home/$i/$videos/$nomearq -p wa -k mush 2>/dev/null
		echo "~# sudo auditctl -w /home/$i/Downloads/$nomearq -p wa -k mush"
	        sudo auditctl -w /home/$i/Downloads/$nomearq -p wa -k mush 2>/dev/null
		echo "~# sudo auditctl -w /home/$i/$documents/$nomearq -p wa -k mush"
	        sudo auditctl -w /home/$i/$documents/$nomearq -p wa -k mush 2>/dev/null
	 	rm -rf ./SINALIZADOR.dat
	 fi	
done


#=======================================================|

#DETECTANDO PASTAS NOVAS================================|
echo -e "\nDETECTANDO NOVAS PASTAS..."
listar_diretorios() {
	local diretorio="$1"
	declare -a diretorios
	for item in "$diretorio"/*; do
		if [ -d "$item" ]; then
			diretorios+=("$item")
			listar_diretorios "$item"
		fi
	done
 	echo "${diretorios[@]}"
}


diretorio_base="/home"

if [ -d "$diretorio_base" ]; then
	diretorios_encontrados=($(listar_diretorios "$diretorio_base"))
	for diretorio in "${diretorios_encontrados[@]}"; do
 		if [ ! -e ""$diretorio"/"$nomearq"" ]; then
   			touch ./SINALIZADOR.dat
      			touch ""$diretorio"/"$nomearq""      			
    			if [ $(stat -c %s ""$diretorio"/"$nomearq"") != $tamanhoHoneyfile ] || [ $(stat -c %s ""$diretorio"/"$nomearq"") != "$tamanhoHoneyfileLess" ]; then
				echo "~# cp ./honeyfile.txt ""$diretorio"/"$nomearq"""
				cp ./honeyfile-less.txt ""$diretorio"/"$nomearq""
   	
   	   			echo "~# sudo auditctl -w ""$diretorio"/"$nomearq"" -p wa -k mush"
		        	sudo auditctl -w ""$diretorio"/"$nomearq"" -p wa -k mush 2>/dev/null
	      		fi
			rm -rf ./SINALIZADOR.dat
	 	fi
	done
fi

#=======================================================|

#VERIFICANDO INSTALAÇÃO===================================|
echo -e "\n VERIFICANDO SOFTWARES..."
if sudo apt-mark showinstall | grep -q auditd; then
	echo -e "\e[32m[OK]\e[0m auditd"
else
    	echo -e "\e[31m[Fail]\e[0m auditd"
fi

if sudo apt-mark showinstall | grep -q inotify-tools; then
 	echo -e "\e[32m[OK]\e[0m inotify-tools"
else
	echo -e "\e[31m[Fail]\e[0m inotify-tools"
fi
#
if sudo apt-mark showinstall | grep -q zip; then
	echo -e "\e[32m[OK]\e[0m zip"
else
	echo -e "\e[31m[Fail]\e[0m zip"
fi
#
if sudo apt-mark showinstall | grep -q wget; then
	echo -e "\e[32m[OK]\e[0m wget"
else
	echo -e "\e[31m[Fail]\e[0m wget"
fi
#-------------------------------------
echo -e "\n VERIFICANDO ARQUIVOS..."
if [ -e ./mushroom.sh ]; then
	echo -e "\e[32m[OK]\e[0m mushroom.sh"
else
	echo -e "\e[31m[Fail]\e[0m mushroom.sh"
fi
#
if [ -e ./backup.sh ]; then
	echo -e "\e[32m[OK]\e[0m backup.sh"
else
	echo -e "\e[31m[Fail]\e[0m backup.sh"
fi
#
if [ -e ./flushlog.sh ]; then
	echo -e "\e[32m[OK]\e[0m flushloge.sh"
else
	echo -e "\e[31m[Fail]\e[0m flushlog.sh"
fi
#
if [ -e ./honeyfile.zip ]; then
	echo -e "\e[32m[OK]\e[0m honeyfile.zip"
else
	echo -e "\e[31m[Fail]\e[0m honeyfile.zip"
fi
#
if [ -e ./honeyfile.txt ]; then
	echo -e "\e[32m[OK]\e[0m honeyfile.txt"
else
	echo -e "\e[31m[Fail]\e[0m honeyfile.txt"
fi
#
if [ -e ./honeyfile-less.txt ]; then
	echo -e "\e[32m[OK]\e[0m honeyfile-less.txt"
else
	echo -e "\e[31m[Fail]\e[0m honeyfile-less.txt"
fi
#
if [ -e ./instalador.sh ]; then
	echo -e "\e[32m[OK]\e[0m instalador.sh"
else
	echo -e "\e[31m[Fail]\e[0m instalador.sh"
fi
#
if [ -e /etc/systemd/system/mushroom.service ] || [ -e ./mushroom.service ]; then
	echo -e "\e[32m[OK]\e[0m mushroom.service"
else
	echo -e "\e[31m[Fail]\e[0m mushroom.service"
fi
#
if [ -e /etc/systemd/system/backup.service ] || [ -e ./backup.service ]; then
	echo -e "\e[32m[OK]\e[0m backup.service"
else
	echo -e "\e[31m[Fail]\e[0m backup.service"
fi
#
if [ -e /etc/systemd/system/flushlog.service ] || [ -e ./flushlog.service ]; then
	echo -e "\e[32m[OK]\e[0m flushlog.service"
else
	echo -e "\e[31m[Fail]\e[0m flushlog.service"
fi
#
if [ -e /etc/systemd/system/instalador.service ] || [ -e ./instalador.service ]; then
	echo -e "\e[32m[OK]\e[0m instalador.service"
else
	echo -e "\e[31m[Fail]\e[0m instalador.service"
fi
#-------------------------------------
echo -e "\n VERIFICANDO ARQUIVOS..."
permission() {
	local arquivoo="$1"
	if [ -x "$arquivoo" ] && [ -r "$arquivoo" ]; then
		echo -e "\e[32m[OK]\e[0m $arquivoo"
	else
		echo -e "\e[31m[Fail]\e[0m $arquivoo"
	fi
}

permission "./instalador.sh"
permission "./mushroom.sh"
permission "./backup.sh"
permission "./flushlog.sh"
permission "./flushlog.service"
permission "./mushroom.service"
permission "./backup.service"
permission "./instalador.service"

if [ -r "./honeyfile.txt" ]; then
	echo -e "\e[32m[OK]\e[0m ./honeyfile.txt"
else
	echo -e "\e[31m[Fail]\e[0m ./honeyfile.txt"
fi
#
if [ -r "./honeyfile-less.txt" ]; then
	echo -e "\e[32m[OK]\e[0m ./honeyfile-less.txt"
else
	echo -e "\e[31m[Fail]\e[0m ./honeyfile-less.txt"
fi

#-------------------------------------
echo -e "\n VERIFICANDO LOCAL DOS ARQUIVOS..."

local() {
	local $arquivoo="$1"
	if [ -e "$arquivoo" ]; then
		echo -e "\e[32m[OK]\e[0m $arquivoo"
	else
		echo -e "\e[31m[Fail]\e[0m $arquivoo"
	fi
}

local "/usr/sbin/instalador.sh"
local "/etc/systemd/system/instalador.service"
local "/usr/sbin/flushlog.sh"
local "/etc/systemd/system/flushlog.service"
local "/usr/sbin/backup.sh"
local "/etc/systemd/system/backup.service"
local "/usr/sbin/mushroom.sh"
local "/etc/systemd/system/mushroom.service"


#-------------------------------------
echo -e "\n VERIFICANDO HONEYFILES..."

checkHoneyfiles() {
	local $arquivoo="$1"
 	if [ $(stat -c %s "$arquivoo") != $tamanhoHoneyfile ]; then
		echo -e "\e[32m[OK]\e[0m '$arquivoo'"
	else
 		echo -e "\e[31m[Fail]\e[0m '$arquivoo'"
   	fi
}

checkHoneyfiles "/$nomearq"
checkHoneyfiles "/root/$nomearq"
checkHoneyfiles "/home/$nomearq"
checkHoneyfiles "/etc/$nomearq"
checkHoneyfiles "/usr/$nomearq"
checkHoneyfiles "/backup/$nomearq"

#-------------------------------------
echo -e "\n VERIFICANDO REGRAS AUDITD..."

regraAuditctl() {
  local regra="$1"

  local -a regras=()
  readarray -t regras < <(auditctl -l)

  for i in "${regras[@]}"; do
    if [[ "$i" == *"$regra"* ]]; then
      echo -e "\e[32m[OK]\e[0m '$regra'"
      return 0
    fi
  done

  echo -e "\e[31m[Fail]\e[0m '$regra'"
  return 1
}

regra="-w /$nomearq -p wa -k mush"
regraAuditctl "$regra"

regra="-w /home/$nomearq -p wa -k mush"
regraAuditctl "$regra"

regra="-w /etc/$nomearq -p wa -k mush"
regraAuditctl "$regra"

regra="-w /usr/$nomearq -p wa -k mush"
regraAuditctl "$regra"

regra="-w /backup/$nomearq -p wa -k mush"
regraAuditctl "$regra"

regra="-w /root/$nomearq -p wa -k mush"
regraAuditctl "$regra"

#=======================================================|

#HABILITANDO SERVICOS===================================|
echo -e "\nHABILITANDO SERVICOS..."

echo "~# sudo systemctl start mushroom.service"
sudo systemctl start mushroom.service
echo "~# sudo systemctl start backup.service"
sudo systemctl start backup.service
echo "~# sudo systemctl start flushlog.service"
sudo systemctl start flushlog.service
echo "~# sudo systemctl start instalador.service"
sudo systemctl start instalador.service
echo "~# sudo systemctl start auditd.service"
sudo systemctl start auditd.service
#=======================================================|

echo -e "\nFINALIZADO!"
echo -e "\n ATENÇÃO.. Nosso software ira proteger apenas seus diretórios (pastas) que não possuam [Espaço]"
echo -e "Ex:\n MinhasFotos - [OK]\n Minhas Fotos - [Vulneravel!]\n Estamos trabalhando para corrigir!..."

