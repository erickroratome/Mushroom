#!/bin/bash
usuarios=$(cat /etc/passwd | grep -i /home | cut -d: -f1)

while true; do
	for i in ${usuarios[@]}; do
		echo "i" > /home/$i/aaaaaaaa.txt
		echo "i" > /home/$i/Desktop/aaaaaaaa.txt
		echo "i" > /home/$i/Videos/aaaaaaaa.txt
		echo "i" > /home/$i/Downloads/aaaaaaaa.txt
		echo "i" > /home/$i/Documents/aaaaaaaa.txt
	done
done
