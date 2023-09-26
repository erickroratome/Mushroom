#!/bin/bash
usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)

while true; do
	for i in ${usuarios[@]}; do
		echo "i" > /home/$i/1@11a.dat
		echo "i" > /home/$i/Desktop/1@11a.dat
		echo "i" > /home/$i/Videos/1@11a.dat
		echo "i" > /home/$i/Downloads/1@11a.dat
		echo "i" > /home/$i/Documents/1@11a.dat
	done
done
