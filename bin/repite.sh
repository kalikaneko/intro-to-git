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
tema=`cat ~/.guarangoradio/data/tmp/repite`
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`

echo "1" > ~/.guarangoradio/data/tmp/repitiendo
killall -9 mplayer 
killall -9 sleep 
killall -9 panico.sh
echo "Repitiendo:--> $nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt 
#~/.guarangoradio/bin/countdown.sh &
#xterm -iconic  -fg Green -bg Red -title "$tema"  -geometry 40x1-0+0 -e mplayer -volume 100 -slave -input file=~/.guarangoradio/data/tmp/slave.txt "$tema"
killall -9 repitetmp.sh
xterm -iconic  -fg Green -bg Red -title "$tema"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/tmp/repitetmp.sh
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
		echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
		echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentsong.txt;
		echo "00:00:00" > ~/.guarangoradio/data/tmp/avance
fi
exit 0
