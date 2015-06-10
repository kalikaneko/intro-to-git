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
killall -9 fadeout.sh
killall -9 mplayer
killall -9 countdown.sh
echo "00:00:00" > ~/.guarangoradio/data/tmp/avance
echo "0" > ~/.guarangoradio/data/tmp/stop
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
killall -9 guarango.sh
killall -9 guarangoauto.sh
killall -9 cargalista.sh
~/.guarangoradio/bin/playmus.sh
else
a=`ps -e |grep guarangoauto.sh`
if [ "$a" = "" ]; then 
#pavumeter &
~/.guarangoradio/bin/guarangoauto.sh &
else
echo "0" > ~/.guarangoradio/data/tmp/repitiendo
echo "0" > ~/.guarangoradio/data/tmp/stop
#~/.guarangoradio/bin/siguiente.sh
fi
fi
