#!/bin/bash

#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#	  Última actualización: 28-Jul-2011    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	        #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.    #
#	    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.	    #
#	    #
############################################################################# 
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
killall -9 guarango.sh
killall -9 guarangoauto.sh
killall -9 cargalista.sh
~/.guarangoradio/bin/playmus.sh
else
echo "1" >  ~/.guarangoradio/data/tmp/desiguiente
echo "0" >  ~/.guarangoradio/data/tmp/repitiendo
killall -9 panico.sh
killall -9 gmplayer
#killall -9 mplayer
tocando=`pidof mplayer`
killall -9 sleep
killall -9 countdown.sh
echo "00:00:00" > ~/.guarangoradio/data/tmp/avance
sleep 1
kill $tocando
fi

if [[ $modo = 1 ]]; then
a=`ps -e |grep cargalista.sh`
if [ "$a" = "" ]; then
~/.guarangoradio/bin/cargalista.sh
fi
fi
