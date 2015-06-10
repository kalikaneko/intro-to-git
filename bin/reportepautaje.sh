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
i=0 
ruta=~/.guarangoradio-shell/data/reporte/pautaje-`date +%Y%m%d`.txt
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
if [ -s ~/.guarangoradio-shell/data/comerciales/$i/$j.com ]; then
echo "==$i horas $j minutos==" >> $ruta
cat ~/.guarangoradio-shell/data/comerciales/$i/$j.com >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done
gedit $ruta
~/.guarangoradio-shell/bin/guarango-gui.sh
