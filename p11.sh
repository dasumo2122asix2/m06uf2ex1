#!/bin/bash
#David Suñer

clear
if (( $EUID != 0 )) # $EUID = 0 if you are running the script with root privileges
then
  echo "This script must be run as a root"
  exit 1 
fi

inst=$(aptitude search pwgen | cut -d " " -f 1)
if [[ $inst != "i" ]]
then
	echo "Instal·lant pwgen"
	aptitude install -y pwgen > /dev/null
fi
rm alumnes.ods
rm alumnes.csv
rm noms.txt
rm contrasenyes_alumnes.txt
clear
wget http://www.collados.org/asix2/m06/uf2/alumnes.ods
if [[ ! -e alumnes.ods ]]
then
	echo "El fitxer no existeix"
	exit 1
else
		libreoffice --headless --convert-to csv alumnes.ods
			cut -d "," -f 2 alumnes.csv > noms.txt
			while read line
			do
			contra=$(pwgen 10 1)
			echo "$line $contra" >> contrasenyes_alumnes.txt
			echo "Completat"
			done < noms.txt
fi

if [[ ! -e contrasenyes_alumnes.txt ]]
then
	echo "Error: El arxiu no s'ha creat correctament"
	exit 1
else
	rm alumnes.ods
	rm alumnes.csv
	rm noms.txt
	clear
	echo "Creació del fitxer contrasenyes alumnes.txt exitosa"
	exit 0
fi

exit 0
