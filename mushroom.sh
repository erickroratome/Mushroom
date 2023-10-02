#!/bin/bash
# Autores: 
# Erick Rorato
# Josué Suptitz
# github.com/erickroratome/Mushroom

#Anti-Ransomware - By:
# _   __           _                                   
#|  \/  |_   _ ___| |__  _ __ ___ ___  _ __ ___  ___ 
#| |\/| | | | / __| '_ \| '__/ _ \ _ \| '_ ` _ \/ __|
#| |  | | |_| \__ \ | | | | | (_) (_) | | | | | \__ \
#|_|  |_|\__,_|___/_| |_|_|  \___/___/|_| |_| |_|___/


while true; do
      PID=$(sudo ausearch -k mush | grep -i ppid | tail -n 1 | grep -o 'pid=[0-9]*' | awk -F'=' '{print $2}')
      if [ -e "./SINALIZADOR.dat" ]; then
		nada="nada"
      else	
		for i in $PID; do
		    kill -9 "$i"
	    	done
      fi
done
