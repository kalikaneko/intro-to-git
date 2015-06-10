#!/bin/bash

#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 20-Ene-2012		    #
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
#Comerciales 
#Después de cada tema aleatorio verifica de acuerdo a la hora si hay
#un comercial que emitir, basado en el minuto de inicio minini y el 
#final min final
#ToDo hacer un script independiente exportando las variables

echo "Comerciales"
function comercialplay() {
	echo funcionplay
	while read comercial;
	do
		inicio=`date +%s` 
		now=`date +%Y%m%d` 

			IFS="|"
			n=0
			for WORD in $comercial
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "
		dia=`date +%u`
		habil=`echo ${data[1]}|sed -ne /$dia/p`	
		if [[ $now -ge ${data[2]} && $now -le ${data[3]}  && $habil -gt 0 ]]; then     					
		mpg321 "${data[0]}"
		fin=`date +%s`
		duracion=$(($fin-$inicio))
		if [ -s ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m` ]; then
		touch ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m`
		fi
		echo `date +%Y-%d-%m-%H:%M`, $comercial, $duracion segundos >> ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales
		fi
		#else se debería borrar con "sed" la línea del comercial
		#que ya no existe, con eso se autodepura la matriz de comerciales
echo ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com				
	done < ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com
}

function comercialplayx() {
	echo funcionplayx
	while read comercial;
	do
		inicio=`date +%s`
		now=`date +%Y%m%d` 

			IFS="|"
			n=0
			for WORD in $comercial
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "
		dia=`date +%u`
		habil=`echo ${data[1]}|sed -ne /$dia/p`	
		if [[ $now -ge ${data[2]} && $now -le ${data[3]}  && $habil -gt 0 ]]; then    					
		mpg321 "${data[0]}"
		fin=`date +%s`
		duracion=$(($fin-$inicio))
		if [ -s ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m` ]; then
		touch ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m`
		fi
		echo `date +%Y-%d-%m-%H:%M`, $comercial, $duracion segundos >> ~/.guarangoradio-shell/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales
		fi
		#else se debería borrar con "sed" la línea del comercial
		#que ya no existe, con eso se autodepura la matriz de comerciales				
	done < ~/.guarangoradio-shell/data/comerciales/$(($hora+1))/$(($minini-60)).com		
}

##Si el tema reproducido tiene menos de un minuto no necesita un lazo		
			if [ $minfin = $minini ]; then
				if [ -s ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com ]; then
				echo "va a while en el mismo minuto"
				comercialplay
				fi
			fi

			minfin=`date  +%-M`
#asegurarse que minini no es igual a minfin 
if [ $minfin -ne $minini ]; then

		if [ $hini = $hfin ]; then			
			echo "va a while en la misma hora"			
			while [ $minini -lt $((minfin+1)) ]; do
			echo minini $minini
			echo minfin $minfin 	
			if [ -s ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com ]; then
				comercialplay
			fi

			minfin=`date +%-M`			
			minini=$(($minini+1))
			echo $minini
			done
		else
			echo "va a while con cambio de hora"		
			while [ $minini -lt $((minfin+61)) ]; do
			echo minini $minini
			echo minfin $minfin 
			echo "va al lazo"
			if [ $minini -lt 60 ]; then
			echo '~/.guarangoradio-shell/data/comerciales/$hora/$minini.com' ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com
				if [ -s ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com ]; then
				comercialplay
				fi
			else 
			echo '~/.guarangoradio-shell/data/comerciales/$hora/$minini.com' ~/.guarangoradio-shell/data/comerciales/$hora/$minini.com
				if [ -s ~/.guarangoradio-shell/data/comerciales/$(($hora+1))/$(($minini-60)).com ]; then
				comercialplayx
				fi
				minfin=`date +%-M`				
			fi
			minini=$(($minini+1))
			done		
		fi

fi
# fin asegurarse que minini no es igual a minfin 
##########################
#Hasta Aquí reproduce comerciales
##########################
echo retorno	

