#!/bin/bash
#David Suñer

clear
if (( $EUID != 0 )) # $EUID = 0 if you are running the script with root privileges
then
  echo "This script must be run as a root"
  exit 1 
fi


for (( ;; ))
do
clear
echo -n "Nom d'usuari: "
read nom
echo -n "Nova contrasenya: "
read -s contra
echo "$nom:$contra" | chpasswd
echo ""
echo "Canvi de contrasenya completat"
echo ""
	echo "Vols continuar?: (s/n)"
	read res
	if [[ $res = y ]]
		then
		clear
	fi
	if [[ $res = n ]]
		then 
		exit 0
		else
		echo "Selecciona una opció correcte"
		fi
done

exit 1
