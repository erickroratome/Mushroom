#!/bin/bash


while true; do
	sleep 30
	echo "" > /var/log/audit/audit.log
	rm -rf /var/log/audit/audit.log.*
	sudo ./instalador.sh
done
