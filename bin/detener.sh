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

kill -9 `cat ~/.guarangoradio/data/pid`
killall -9 guarangoauto.sh
killall -9 tiempo.sh
killall -9 mplayer
killall -9 guarango.sh
killall -9 cargalista.sh
killall -9 pavumeter
killall -9 comercialdaemon.sh
killall -9 playmancom.sh
killall -9 countdown.sh
#~/.guarangoradio/bin/fadeout.sh
echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt
echo "Visor de Temas Musicales" > ~/.guarangoradio/data/tmp/currentsong.txt
exit 0
