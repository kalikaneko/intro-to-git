#!/bin/bash
usuario=`whoami`
nombre=`zenity --entry --text "Ingrese el nombre de su radio"`
echo "$nombre" > /home/$usuario/.guarangoradio/data/tmp/radio