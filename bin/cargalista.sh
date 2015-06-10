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

echo "======================================================="
echo "Guarango Radio -v:webteraba ***Carga Lista****"
salir=0
nlinea=1
playlist=0
while [ $salir=0 ]; do  #1
		listatemas=5
		hora=`date  +%-H` 
		dia=`date +%u`
		fecha=`date +%-9d-%-m-%-Y-%-H_%-M`

		##Determinar el número de lineas playlist de la lista
		ranura=`echo "$hora-$(($hora+1)).mus"`
		nlineas=`grep -c $ ~/.guarangoradio/data/parrilla/$dia/$ranura`
		hora1=`date  +%-H` 
		#playlist=0

	#echo "la ranura tiene:" $nlineas "lineas y nlinea parte de:" $nlinea >> ~/.guarangoradio/data/tmp/gr-$fecha.log
	while [ $hora = $hora1 ]; do  #2

	#Construye un playlis de 5 temas

			playlist=`grep -c $ ~/.guarangoradio/data/tmp/playlist`
			

			#echo "playlist inicial" $playlist >> ~/.guarangoradio/data/tmp/gr-$fecha.log
			while [ $playlist -lt $listatemas ]; do #3
			if [ -s ~/.guarangoradio/data/parrilla/$dia/$ranura ]; then	#fi1
					nlinea=1 
					
				while [ $nlinea -le $nlineas ]; do #4
				#echo nlinea: $nlinea >> ~/.guarangoradio/data/tmp/gr-$fecha.log

				line="`sed -n $nlinea"p" ~/.guarangoradio/data/parrilla/$dia/$ranura`" 

				if [[ $hora = $hora1 ]]; then #fi3

				ouch=0		
				if [[ $line = "Hora" ]]; then #fi4
						echo Hora >> ~/.guarangoradio/data/tmp/playlist	
						randomfile="Hora"
						echo "<font size="1" color="green"><b>$randomfile</b></font></br>" >> ~/.guarangoradio/data/tmp/playlistweb
						echo "$randomfile" >> ~/.guarangoradio/data/tmp/playlistg3
				else #fi4
					line=`echo -e "${line}"|sed  s/\'//g` #Con asterisco
					#echo "line filtro1" $line >> ~/.guarangoradio/data/tmp/gr-$fecha.log
					
					line=`echo -e "${line}"|sed  s/"*"/""/g` #|sed  s/" "/"\\\\ "/g` #sin esterisco y limpiado


			if [[ -f "$line" ]]; then #Es archivo?				

				extension="${line##*.}"
						validado=`grep -i $extension ~/.guarangoradio/data/extensiones`
							if [ "$validado" != "" ]; then #fi5 es archivo?
						randomfile=$line
						duracion=`avconv -i "$randomfile"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'`
						nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
						echo "$randomfile" >> ~/.guarangoradio/data/tmp/playlist 
						echo "<font size='1' color='green'><b>$nombrebase</b></font></br>" >> ~/.guarangoradio/data/tmp/playlistweb
						echo "$nombrebase" "["$duracion"]" >> ~/.guarangoradio/data/tmp/playlistg3
						#echo "archivo:" $randomfile >> ~/.guarangoradio/data/tmp/gr-$fecha.log
			fi #es archivo?

					else #fi5 es carpeta?
					if [[ -d "$line" ]]; then # Es directorio?
						files=`ls -R "$line"|grep -c $`
						if [[ $ouch = 0 ]]; then #fi6

						yatocado=1
						infinito=0
						encabezado=""
						while [[ $yatocado = 1 || $encabezado != "" ]]; do

						randomico=$((RANDOM % $files))
						#echo "randomico:" $randomico >> ~/.guarangoradio/data/tmp/gr-$fecha.log
							if [[ $randomico != 0 ]]; then #00
								
							
								temabase="`ls -R "$line"|sed -n $randomico"p"`"
								#echo "temabase" $temabase #>> ~/.guarangoradio/data/tmp/gr-$fecha.log
							
								encabezado=`echo $temabase|grep \/:`
								#echo "encabezado" $encabezado
								if [[ $encabezado = "" ]]; then
								randomfile=`find "$line" -name "$temabase" -print|sed -n 1p`
								fi
								if [[ "$randomfile" != "" ]]; then #fi7
								extension="${randomfile##*.}"
								validado=`grep -i $extension ~/.guarangoradio/data/extensiones`
							if [ "$validado" != "" ]; then #fi8	
										#echo "extensión desde randomico" $extension #>> ~/.guarangoradio/data/tmp/gr-$fecha.log
										valido=1

							else
										#echo "no cumple extension" >> ~/.guarangoradio/data/tmp/gr-$fecha.log				
										valido=0
							fi #fi8
								#Control de random para no repetir
								nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
								ruta=`echo "$randomfile"|sed s/"\/$nombrebase"//g`
									control=""
									if [[ -s "$ruta"/.historico.mus ]]; then
									control=`grep "$nombrebase" "$ruta"/.historico.mus`
									fi
								control1=`grep "$nombrebase" ~/.guarangoradio/data/tmp/playlist`
									echo "control:" $control "control1" $control1 "valido" $valido
								if [[ $control = "" && $control1 = "" && $valido = 1 ]]; then
								yatocado=0
								fi
								#echo "yatocado:" $yatocado

								#echo "files:" $files >> ~/.guarangoradio/data/tmp/gr-$fecha.log
								else
								echo "error randomico fue" $randomico #>> ~/.guarangoradio/data/tmp/gr-$fecha.log
							
							fi #00	
							#encabezado=`echo $temabase|grep \/:`
							
						ouch=0	
						fi #ouch fi 7
					infinito=$(($infinito +1))
					#echo "infinito" $infinito
								if [[ $files -lt 5 || $infinito -gt 600 ]]; then
								yatocado=0
								fi
					if [[ $infinito -gt 500 && -s "$ruta"/.historico.mus ]]; then
					rm "$ruta"/.historico.mus
					# 1000 intentos deberían ser suficientes :)
					fi
					done #ya tocado

										echo "$randomfile" >> ~/.guarangoradio/data/tmp/playlist
										duracion=`avconv -i "$randomfile"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'`
										echo "<font size='1' color='green'><b>"$temabase"</b></font></br>" >> ~/.guarangoradio/data/tmp/playlistweb
										echo "$temabase" "[""$duracion""]"  >> ~/.guarangoradio/data/tmp/playlistg3
						fi #fi 6
				else
				#echo "no encontre la carpeta" $line >> ~/.guarangoradio/data/tmp/gr-$fecha.log	
				randomfile=""
				fi # es directorio?
					fi #fi4

				fi #fi3
						hora1=`date  +%"-H"`

						#echo "randomfile a playlist -->" $randomfile >> ~/.guarangoradio/data/tmp/gr-$fecha.log	

					playlist=`grep -c $ ~/.guarangoradio/data/tmp/playlist`

							while [[ $playlist -ge $listatemas ]]; do
							#echo "playlist es ge que listatemas"
							sleep 3

							dropfinal=`cat ~/.guarangoradio/data/tmp/ultimodrop`
							if [[ $dropfinal = "1" ]]; then
							sleep 3
							echo "0" > ~/.guarangoradio/data/tmp/ultimodrop
							fi		

							playlist=`grep -c $ ~/.guarangoradio/data/tmp/playlist`
							done	

							
				
				
			else
				playlist=$(($playlist+1))
			
			fi #fi1	
			nlinea=$(($nlinea+1))
			~/.guarangoradio/bin/cartucho.sh &
			done #4 
			
		else #fi1
			#killall -9 zenity
			zenity --warning --title="Alerta" --text "No existe parrilla musical programada a la $hora horas" &
			playlist=$listatemas

			hora1=`date  +%"-H"`
			echo "hora" $hora "hora1" $hora1
			sleep 60
		fi #fi1
			
			#echo playlist: $playlist >> ~/.guarangoradio/data/tmp/gr-$fecha.log
			#echo listatemas: $listatemas >> ~/.guarangoradio/data/tmp/gr-$fecha.log
			
		done #3
		exec ~/.guarangoradio/bin/cartucho.sh &
			#exit 0		
	#hora1=`date  +%"H"`mortal error
	hora1=`date  +%-H` 
	#echo "hora:" $hora "hora1:"$hora1 >> ~/.guarangoradio/data/tmp/gr-$fecha.log
	#sleep 3
	done #2
	#echo "salio de lazo de hora" >> ~/.guarangoradio/data/tmp/gr-$fecha.log
done #1
