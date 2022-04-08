#!/bin/bash
#David Suñer

clear
if (( $EUID != 0 )) # $EUID = 0 if you are running the script with root privileges
then
  echo "This script must be run as a root"
  exit 1 
fi

DATA=$(date +20%y%m%d%H%M)

echo -n "Fitxer: "
read fitxer

if [[ ! -e /etc/default/$fitxer ]]
then
	echo "Error: El fitxer demanat no existeix"
	exit 1
else
	cp /etc/default/$fitxer /media/$fitxer.$DATA
	echo "Copia exitosa"
	exit 0
fi
