#!/bin/bash
#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 28-Jul-2011		    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	    		    #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.								    #
#									    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.							    #
#									    #
############################################################################# 


# Establece el editor a usar
if [ -f /usr/bin/pluma ]
then
        EDITOR="pluma"
elif [ -f /usr/bin/leafpad ]
then
        EDITOR="leafpad"
elif [ -f /usr/bin/mousepad ]
then
        EDITOR="mousepad"
else
        EDITOR="gedit"
fi

i=0 
ruta=~/.guarangoradio/data/reporte/pautaje-`date +%Y%m%d`.txt
echo Reporte de pautaje `date +%Y-%m-%d` > $ruta
echo " " >> $ruta
echo Formato":" Comercial"|"Días de la semana"|"Fecha inicio"|"Fecha fin >> $ruta
echo "Días de la semana; 1=lunes 2=martes 3=miércoles ...... 7=domingo" >> $ruta
echo " " >> $ruta
echo ======================================================================== >> $ruta
echo " " >> $ruta
while [ $i -le 23 ]; do
j=0
while [ $j -le 59 ]; do
if [ -s ~/.guarangoradio/data/comerciales/$i/$j.com ]; then
echo "==$i horas $j minutos==" >> $ruta
cat ~/.guarangoradio/data/comerciales/$i/$j.com >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done
$EDITOR $ruta
#~/.guarangoradio/bin/guarango-gui.sh
