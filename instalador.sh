#!/bin/bash
# Autores: 
# Erick Rorato
# Josué Suptitz
# github.com/erickroratome/Mushroom

echo -e "\n\nAnti-Ransomware - By:"
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

#VERIFICANDO LOCAL DA EXECUCAO==========================|
onde=$(pwd)
if [ ! -e "$onde/instalador.sh" ]; then
	echo "Execute no mesmo diretório do instalador..."
 	exit
fi
#=======================================================|

#VERIFICANDO SOFTWARES INSTALADOS=======================|
echo -e "\nCHECANDO SOFTWARES INSTALADOS..."
function instalacao() {
	local arquivoo="$1"
 	local erro="1"
  	while [ $erro != "0" ]; do	   
		if sudo apt-mark showinstall | grep -q $arquivoo; then
			echo "[OK] $arquivoo"
   			erro="0"
		else
		        echo -e "\n\n$arquivoo nao instalado!\n"
		        echo -e "Deseja instalar?\n"
		        read -p "[S]im | [N]ao: " resp
		        if [ $resp = "S" ] || [ $resp = "s" ]; then
		                echo ""
		                apt update -y
				apt-get install $arquivoo -y
			        if sudo apt-mark showinstall | grep -q $arquivoo; then
		  			erro="0"
				else
	   				erro="1"
	       			fi
	  		else
		                echo "Para continuar instale o software!"
		                exit 1
		        fi
		fi
  	done
}
instalacao "auditd"
instalacao "inotify-tools"
instalacao "wget"
instalacao "zip"
#=======================================================|

#CHECANDO O ARQUIVOS====================================|
echo -e "\nCHECANDO ARQUIVOS..."

url="https://github.com/erickroratome/Mushroom/"
function checkArqs() {
	local arquivoo="$1"
	if [ -e "./$arquivoo" ]; then
		echo "[OK] $arquivoo"
	else
		echo "[FAIL] $arquivoo"
      		echo "~# wget "$url/raw/main/$arquivoo""
		wget "$url/raw/main/$arquivoo"
  		echo ""
	fi
}
function checkArqSystemd() {
	local arquivoo="$1"
	if [ -e "/etc/systemd/system/$arquivoo" ] || [ -e "./$arquivoo" ]; then
		echo "[OK] $arquivoo"
	else
		echo "[FAIL] $arquivoo"
      		echo "~# wget "$url/raw/main/$arquivoo""
		wget "$url/raw/main/$arquivoo"
  		echo ""
	fi
}
checkArqs "mushroom.sh"
checkArqs "backup.sh"
checkArqs "flushlog.sh"
checkArqs "honeyfile.zip"
checkArqs "instalador.sh"
checkArqSystemd "mushroom.service"
checkArqSystemd "backup.service"
checkArqSystemd "flushlog.service"
checkArqSystemd "instalador.service"

if [ -e ./mushroom.sh ] && [ -e ./backup.sh ] && [ -e ./instalador.sh ] && [ -e ./honeyfile.zip ] && [ -e ./mushroom.service ] && [ -e ./backup.service ] && [ -e ./flushlog.sh ] && [ -e ./flushlog.service ]; then
	nada="nada"
elif [ -e /etc/systemd/system/mushroom.service ] && [ -e /etc/systemd/system/backup.service ] && [ -e /etc/systemd/system/flushlog.service ]; then
	nada="nada"
else
	echo -e"\n\n\nFALTANDO ARQUIVOS CRUCIAIS PARA O FUNCIONAMENTO DO SISTEMA...\n"
	echo -e"\n\n\n$(date) FALTANDO ARQUIVOS CRUCIAIS PARA O FUNCIONAMENTO DO SISTEMA...\n" >> ./mushlog.txt
	exit 1
fi
#=======================================================|

#DESCOMPACTANDO .ZIP====================================|
tamanhoHoneyfile=123855156
tamanhoHoneyfileLess=19051201

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
#=======================================================|

#ALTERANDO PERMISSOES===================================|
echo -e "\nALTERANDO PERMISSOES..."
function perms() {
	local arquivoo="$1"
 	local arquivoo2="$2"
	echo "~# sudo chown root:root "$arquivoo""
	sudo chown root:root "$arquivoo"
	echo "~# sudo -u root chmod $arquivoo2 "$arquivoo""
	sudo -u root chmod "$arquivoo2" "$arquivoo"
}
perms "./instalador.sh" "500"
perms "./mushroom.sh" "500"
perms "./backup.sh" "500"
perms "./mushroom.sh" "500"
perms "./flushlog.sh" "500"
perms "./honeyfile.zip" "444"
perms "./honeyfile.txt" "444"

function perms777Systemd() {
	local arquivoo="$1"
	if [ ! -e ./$arquivoo ]; then
		echo "~# sudo chown root:root /etc/systemd/system/$arquivoo"
		sudo chown root:root /etc/systemd/system/$arquivoo
		echo "~# sudo -u root chmod 777 /etc/systemd/system/$arquivoo"
		sudo -u root chmod 777 /etc/systemd/system/$arquivoo
	else
		echo "~# sudo chown root:root ./$arquivoo"
		sudo chown root:root ./$arquivoo
		echo "~# sudo -u root chmod 777 ./$arquivoo"
		sudo -u root chmod 777 ./$arquivoo
	fi
}
perms777Systemd "flushlog.service"
perms777Systemd "mushroom.service"
perms777Systemd "backup.service"
perms777Systemd "instalador.service"
#=======================================================|

#MOVENDO ARQUIVOS=======================================|
echo -e "\nMOVENDO ARQUIVOS..."
function move() {
	local arquivoo="$1"
 	local arquivoo2="$2"
  	if [ ! -e "./$arquivoo2" ]; then
		echo "~# cp ./$arquivoo "$arquivoo2""
		cp ./$arquivoo "$arquivoo2"
  	fi
}
move "instalador.sh" "/usr/sbin/instalador.sh"
move "instalador.service" "/etc/systemd/system/instalador.service"
move "mushroom.sh" "/usr/sbin/mushroom.sh"
move "mushroom.service" "/etc/systemd/system/mushroom.service"
move "backup.sh" "/usr/sbin/backup.sh"
move "backup.service" "/etc/systemd/system/backup.service"
move "flushlog.sh" "/usr/sbin/flushlog.sh"
move "flushlog.service" "/etc/systemd/system/flushlog.service"
#=======================================================|

#HABILITANDO .SERVICES==================================|
echo -e "\nHABILITANDO .SERVICES..."
echo "~# sudo systemctl daemon-reload"
sudo systemctl daemon-reload
function habilitar() {
	local arquivoo="$1"
 	if systemctl is-enabled "$arquivoo" > /dev/null; then
		echo "[Ja habilitado..] "$arquivoo""
 	else
  		echo "~# sudo systemctl enable $arquivoo"
		sudo systemctl enable $arquivoo
		echo ""
  	fi
}
habilitar "mushroom.service"
habilitar "backup.service"
habilitar "flushlog.service"
habilitar "instalador.service"
habilitar "auditd.service"

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
function regraAuditctl() {
  	local locaal="$1"
	echo "~# sudo auditctl -w "$locaal" -p wa -k mush"
	sudo auditctl -w "$locaal" -p wa -k mush 2>/dev/null
}
touch /usr/sbin/SINALIZADOR.dat
regraAuditctl "/$nomearq"
regraAuditctl "/home/$nomearq"
regraAuditctl "/etc/$nomearq"
regraAuditctl "/usr/$nomearq"
regraAuditctl "/backup/$nomearq"
regraAuditctl "/root/$nomearq"
rm -rf /usr/sbin/SINALIZADOR.dat

if [ -e /root/$nomearq ] && [ $(stat -c %s /root/$nomearq) = $tamanhoHoneyfile ] && [ -e /$nomearq ] && [ $(stat -c %s /$nomearq) = $tamanhoHoneyfile ] && [ -e /home/$nomearq ] && [ -e /etc/$nomearq ] && [ -e /usr/$nomearq ] && [ $(stat -c %s /home/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /etc/$nomearq) = $tamanhoHoneyfile ] && [ $(stat -c %s /usr/$nomearq) = $tamanhoHoneyfile ] && [ -e /backup/$nomearq ] && [ $(stat -c %s /backup/$nomearq) = $tamanhoHoneyfile ]; then
        echo ""
else
	echo -e "\nESPALHANDO HONEYFILES NO SISTEMA..."

 	function espalhandoHoneys() {
  		local locaal="$1"
    		touch /usr/sbin/SINALIZADOR.dat
      		touch "$locaal"
 		if [ $(stat -c %s "$locaal") != $tamanhoHoneyfile ]; then
			echo "~# cp ./honeyfile.txt "$locaal""
        		cp ./honeyfile.txt "$locaal" 2>/dev/null
        		chmod 777 "$locaal"
		fi
  		rm -rf /usr/sbin/SINALIZADOR.dat
    	}
	espalhandoHoneys "/$nomearq"
	espalhandoHoneys "/root/$nomearq"
	espalhandoHoneys "/home/$nomearq"
	espalhandoHoneys "/etc/$nomearq"
  	espalhandoHoneys "/usr/$nomearq"
   	mkdir /backup 2>/dev/null
   	espalhandoHoneys "/backup/$nomearq"
fi

echo -e "\nCHECANDO DIRETÓRIOS DO USUARIO..."
for i in ${usuarios[@]}; do
	if [ ! -d /home/$i ]; then
 		nada="nada"
   	else
    		#===========================================================
	 	function checkDir() {
	  		local locaal="$1"
			if [ ! -d "$locaal" ]; then
			    touch /usr/sbin/SINALIZADOR.dat
			    echo "~# sudo mkdir "$locaal""
			    sudo -u "$i" mkdir "$locaal"
			    rm -rf /usr/sbin/SINALIZADOR.dat
		     	else
		      	    echo "[OK] "$locaal""
			fi
	    	}
		checkDir "/home/$i/$documents"
  		checkDir "/home/$i/Downloads"
    		checkDir "$desktop"
      		checkDir "/home/$i/$videos"
		checkDir "/home/$i/$videos"
		#===========================================================
  		echo -e "\nESPALHANDO HONEYFILES NO HOME USUARIO..."
  		function espHoneyFilesUser() {
	  		local locaal="$1"
			sudo touch "$locaal"
			if [ $(stat -c %s "$locaal") != $tamanhoHoneyfile ]; then
		 		touch /usr/sbin/SINALIZADOR.dat
				echo "~# cp ./honeyfile.txt "$locaal""
				cp ./honeyfile.txt  "$locaal"
		  		rm -rf /usr/sbin/SINALIZADOR.dat
		 	fi
	    	}
		espHoneyFilesUser "/home/$i/$nomearq"
  		espHoneyFilesUser "/home/$i/$documents/$nomearq"
    		espHoneyFilesUser "/home/$i/Downloads/$nomearq"
      		espHoneyFilesUser "$desktop/$nomearq"
		espHoneyFilesUser "/home/$i/$videos/$nomearq"
		#===========================================================
		echo -e "\nMUDANDO PERMISSOES..."
	 	touch /usr/sbin/SINALIZADOR.dat
   		perms "/home/$i/$nomearq" "777"
		perms "/home/$i/$documents/$nomearq" "777"
  		perms "/home/$i/Downloads/$nomearq" "777"
		perms "$desktop/$nomearq" "777"
  		perms "/home/$i/$videos/$nomearq" "777"
     		rm -rf /usr/sbin/SINALIZADOR.dat
       		
	  	#echo "~# chmod 777 /home/$i/$nomearq"
		#chmod 777 /home/$i/$nomearq 2>/dev/null
	 	#echo "~# chmod 777 /home/$i/$documents/$nomearq"
	        #chmod 777 /home/$i/$documents/$nomearq 2>/dev/null
		#echo "~# chmod 777 /home/$i/Downloads/$nomearq"
	        #chmod 777 /home/$i/Downloads/$nomearq 2>/dev/null
		#echo "~# chmod 777 "$desktop/$nomearq""
	        #chmod 777 "$desktop/$nomearq" 2>/dev/null
		#echo "~# chmod 777 /home/$i/$videos/$nomearq"
	        #chmod 777 /home/$i/$videos/$nomearq 2>/dev/null
		#===========================================================
		echo -e "\nADICIONANDO REGRAS PARA AUDITCTL..."
  		touch /usr/sbin/SINALIZADOR.dat
		regraAuditctl "/home/$i/$nomearq"
		regraAuditctl "$desktop/$nomearq"
  		regraAuditctl "/home/$i/$videos/$nomearq"
		regraAuditctl "/home/$i/Downloads/$nomearq"
		regraAuditctl "/home/$i/$documents/$nomearq"
		rm -rf /usr/sbin/SINALIZADOR.dat
	 	#echo "~# sudo auditctl -w /home/$i/$nomearq -p wa -k mush"
	        #sudo auditctl -w /home/$i/$nomearq -p wa -k mush 2>/dev/null
		#echo "~# sudo auditctl -w "$desktop/$nomearq" -p wa -k mush"
	        #sudo auditctl -w "$desktop/$nomearq" -p wa -k mush 2>/dev/null
		#echo "~# sudo auditctl -w /home/$i/$videos/$nomearq -p wa -k mush"
	        #sudo auditctl -w /home/$i/$videos/$nomearq -p wa -k mush 2>/dev/null
		#echo "~# sudo auditctl -w /home/$i/Downloads/$nomearq -p wa -k mush"
	        #sudo auditctl -w /home/$i/Downloads/$nomearq -p wa -k mush 2>/dev/null
		#echo "~# sudo auditctl -w /home/$i/$documents/$nomearq -p wa -k mush"
	        #sudo auditctl -w /home/$i/$documents/$nomearq -p wa -k mush 2>/dev/null
	 	#rm -rf /usr/sbin/SINALIZADOR.dat
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
   			touch /usr/sbin/SINALIZADOR.dat
      			touch ""$diretorio"/"$nomearq""      			
    			if [ $(stat -c %s ""$diretorio"/"$nomearq"") != $tamanhoHoneyfile ] || [ $(stat -c %s ""$diretorio"/"$nomearq"") != "$tamanhoHoneyfileLess" ]; then
				echo "~# cp ./honeyfile.txt ""$diretorio"/"$nomearq"""
				cp ./honeyfile-less.txt ""$diretorio"/"$nomearq""
   	
   	   			echo "~# sudo auditctl -w ""$diretorio"/"$nomearq"" -p wa -k mush"
		        	sudo auditctl -w ""$diretorio"/"$nomearq"" -p wa -k mush 2>/dev/null
	      		fi
			rm -rf /usr/sbin/SINALIZADOR.dat
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
	echo -e "\e[32m[OK]\e[0m flushlog.sh"
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
echo -e "\n VERIFICANDO PERISSOES DE ARQUIVOS..."
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

locaal() {
	local arquivoo="$1"
	if [ -e "$arquivoo" ]; then
		echo -e "\e[32m[OK]\e[0m $arquivoo"
	else
		echo -e "\e[31m[Fail]\e[0m $arquivoo"
	fi
}

locaal "/usr/sbin/instalador.sh"
locaal "/etc/systemd/system/instalador.service"
locaal "/usr/sbin/flushlog.sh"
locaal "/etc/systemd/system/flushlog.service"
locaal "/usr/sbin/backup.sh"
locaal "/etc/systemd/system/backup.service"
locaal "/usr/sbin/mushroom.sh"
locaal "/etc/systemd/system/mushroom.service"


#-------------------------------------
echo -e "\n VERIFICANDO HONEYFILES..."

checkHoneyfiles() {
	local arquivoo="$1"
 	if [ $(stat -c %s "$arquivoo") = $tamanhoHoneyfile ]; then
		echo -e "\e[32m[OK]\e[0m $arquivoo"
	else
 		echo -e "\e[31m[Fail]\e[0m $arquivoo"
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
  readarray -t regras < <(sudo auditctl -l)

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

#ATIVANDO SERVICOS===================================|
echo -e "\nATIVANDO SERVICOS..."
function ativar() {
	local arquivoo="$1"
 	if systemctl is-active "$arquivoo" > /dev/null; then
		echo "[Ja ativado..] "$arquivoo"
 	else
		echo "~# sudo systemctl start "$arquivoo""
		sudo systemctl start "$arquivoo"
		echo ""
  	fi
}
ativar "mushroom.service"
ativar "backup.service"
ativar "flushlog.service"
ativar "auditd.service"
#=======================================================|

echo -e "\nFINALIZADO!"
echo -e "\n ATENÇÃO.. Nosso software ira proteger apenas seus\ndiretórios (pastas) que não possuam [Espaço]"
echo -e "Ex:\n \e[32m[ Protegido ] - /home/MinhasFotos\e[0m\n \e[31m[Vulneravel!] - /home/Minhas Fotos\e[0m\n\nEstamos trabalhando para corrigir!..."
