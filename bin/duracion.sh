#!/bin/bash
#tiempo
tema=`cat ~/.guarangoradio/data/tmp/currentsong.txt| sed  s/" "/"\\\\ "/g |sed  s/\"//g`
echo tema "$tema" 
duracion=`avconv -i "$tema"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//` 
echo $duracion time    			
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
segundos=`echo $minuto + $segundos|bc`
segundos=`echo $hora + $segundos|bc`
echo $segundos  segundos

