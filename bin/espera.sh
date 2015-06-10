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
#tiempo
mix=`cat ~/.guarangoradio/data/mix.txt`
echo $$ > ~/.guarangoradio/data/pidplay
tema=`cat ~/.guarangoradio/data/tmp/currentsong.txt| sed  s/" "/"\\\\ "/g |sed  s/\"//g`
#echo tema "$tema" 
duracion=`avconv -i "$tema"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//` 
#echo $duracion time    			
			IFS=":"
			n=0
			for duracion in $duracion
			do
			dura[$n]=$duracion
			n=$(($n+1))
			done
			IFS=" "
hora=`expr ${dura[0]} \* 3600`
minuto=`expr ${dura[1]} \* 60`
segundos="${dura[2]}"
segundos=`echo "($segundos+0.5)/1" | bc`
#echo hora=$hora minuto=$minuto segundo=$segundos
segundos=`echo $minuto + $segundos|bc`
segundos=`echo $hora + $segundos|bc`
echo Duración total: $segundos segundos 

mix=`echo $segundos - $mix|bc` 
echo $mix > ~/.guarangoradio/data/mix
echo Mezcla a los: $mix segundos
sleep $mix
