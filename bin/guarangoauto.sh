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
function tiempo() {
echo "funciontiempo en guarango.sh"
duracion=`avconv -i "$1"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'` 
echo "$duracion" > ~/.guarangoradio/data/tmp/duracion
echo "duracion" $duracion
			IFS=":"
			n=0
			for duracion in $duracion
			do
			dura[$n]=$duracion
			n=$(($n+1))
			done
			IFS=" "
				horas=`expr ${dura[0]} \* 3600`
				minutof=`expr ${dura[1]} \* 60`
				segundos=`echo "(${dura[2]}+0.5)/1"|bc`
				segundos=`echo $minutof + $segundos|bc`
				segundos=`echo $horas + $segundos|bc`
				echo segundos $segundos
				duracion=$segundos
				return $segundos
}
###############INICIO PROGRAMA######################
killall -9 comercialdaemon.sh
killall -9 cargalista.sh
echo "======================================================="
echo "Guarango Radio -v:carnivale"
echo $$ > ~/.guarangoradio/data/pid

					echo "Cargando.." > ~/.guarangoradio/data/tmp/avance
					echo "Cargando" > ~/.guarangoradio/data/tmp/avanceweb
#~/.guarangoradio/bin/guarango-gui.sh &
#Reproducir desde la parrilla
#Determinar dia de la semana y hora
echo "Modo Automático" > ~/.guarangoradio/data/tmp/currentcomercial.txt;

#Vaciar playlist y Comerciales
cat /dev/null > ~/.guarangoradio/data/tmp/playlistg3
cat /dev/null > ~/.guarangoradio/data/tmp/playlist
cat /dev/null > ~/.guarangoradio/data/tmp/playlistweb
cat /dev/null > ~/.guarangoradio/data/tmp/cartucho1
cat /dev/null > ~/.guarangoradio/data/tmp/cartucho2
cat /dev/null > ~/.guarangoradio/data/tmp/cartucho3
cat /dev/null > ~/.guarangoradio/data/tmp/cartucho4
cat /dev/null > ~/.guarangoradio/data/tmp/cartucho5
sed -i "1d" ~/.guarangoradio/data/tmp/playlist
sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3

#Las siguientes lineas vacían los comerciales, pero si el operador
#cierra y abre el programa por emergencia, perderá los comerciales no pautados
#en todo caso puede borrar manualmente los comerciales

#cat /dev/null > ~/.guarangoradio/data/tmp/comercialeslist
#cat /dev/null > ~/.guarangoradio/data/tmp/comercialeslistweb
#cat /dev/null > ~/.guarangoradio/data/tmp/comercialeslistwebg3
#sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
#sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistweb
#sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistwebg3

#Vaciar eventos
cat /dev/null > ~/.guarangoradio/data/tmp/eventoslist
cat /dev/null > ~/.guarangoradio/data/tmp/eventoslistweb
cat /dev/null > ~/.guarangoradio/data/tmp/eventoslistwebg3
sed -i "1d" ~/.guarangoradio/data/tmp/eventoslist
sed -i "1d" ~/.guarangoradio/data/tmp/eventoslistweb
sed -i "1d" ~/.guarangoradio/data/tmp/eventoslistwebg3

~/.guarangoradio/bin/cargalista.sh & #xterm -iconic  -e 

z=`ps -e |grep comercialdaemon.sh`
if [ "$z" = "" ]; then 
~/.guarangoradio/bin/comercialdaemon.sh & #xterm -iconic  -e 
fi
sleep 1 #Tiempo para que el cargalista cargue el playlist
					echo "Listo!" > ~/.guarangoradio/data/tmp/avance
					echo "Listo!" > ~/.guarangoradio/data/tmp/avanceweb


salir=0
saliolazo=0
#################################################
while [ $salir=0 ]; do
minini=`date  +%-M`
hini=`date +%-H`
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
echo `date`
previo="inicio"

ranura=`echo "$hora-$(($hora+1)).mus"`


echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt
echo "Visor de Temas Musicales" > ~/.guarangoradio/data/tmp/currentsong.txt

##Determinar el número de lineas de playlist
nlineas=`grep -c $ ~/.guarangoradio/data/tmp/playlist`
hora1=`date  +%-H` 
echo nlineas: $nlineas
while [ $hora = $hora1 ]; do
		echo ranura $ranura 
nlineas=`grep -c $ ~/.guarangoradio/data/tmp/playlist`

#########################PARRILLA MUSICAL#####################################################


	if [[ $nlineas -ge 1 ]]; then		
		nlinea=1 
		while [ $nlinea -le $nlineas ]; do 

			estadotv=`cat ~/.guarangoradio/data/tmp/tvestado`
			desplazamiento=`cat ~/.guarangoradio/data/tmp/tvdesplazamiento`
			teletexto=`cat ~/.guarangoradio/data/tmp/teletexto`
			if [[ $estadotv = 1 ]]; then
			tvopcion="-fs -geometry $desplazamiento"
			else
			tvopcion=""
			fi
			srt=~/.guarangoradio/data/tmp/teletexto.srt
			color=`cat ~/.guarangoradio/data/tmp/teletexto.color`
			if [[ $estadotv = 1 && $teletexto = 1 ]]; then
			srtopcion="-sub $srt $color "
			else
			srtopcion=""
			fi
				
				echo 0 > ~/.guarangoradio/data/tmp/repitiendo
				randomfile=`sed -n 1p ~/.guarangoradio/data/tmp/playlist`

				nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
				musini=`date +%s`					
	
			if [[ $randomfile = "Hora" && $previo != "$randomfiles" ]];
				then	
					twitter=`cat ~/.guarangoradio/data/tmp/twidge`
					mix=`cat ~/.guarangoradio/data/mix.txt`
					nombrebase="Hora"
					echo "Hora" > ~/.guarangoradio/data/tmp/currentsong.txt 
					echo "Hora" ~/.guarangoradio/data/tmp/currentsongweb
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo la hora"|twidge update & 
					fi
					echo "Hora" ~/CurrenSong.txt
					killall -9 countdown.sh
					echo "Hora" > ~/.guarangoradio/data/tmp/avance
					echo "<font color='red' size='24'><b>Hora</b></font>" > ~/.guarangoradio/data/tmp/avanceweb
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
						echo randomfile $randomfile

					~/.guarangoradio/bin/cartucho.sh &
					
						desiguiente=`cat ~/.guarangoradio/data/tmp/desiguiente`
						if [[ $desiguiente = 0 ]]; then
						sleep $(($mix-2))
						fi

					xterm -iconic  -fg Green -bg DarkBlue -title "hora" -geometry 40x1-0+0  -e ~/.guarangoradio/data/panel/hora.sh

						previo="$randomfile"

						sed -i "1d" ~/.guarangoradio/data/tmp/playlist
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
						desiguiente=0
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.guarangoradio/bin/detenermanual.sh
fi


			else
				if [[ -s "$randomfile" ]]; then
					echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt
					echo "$nombrebase" > ~/CurrentSong.txt
					twitter=`cat ~/.guarangoradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo $nombrebase"|twidge update &
					fi

					echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb

					if [[ `cat ~/.guarangoradio/data/tmp/mezcla` = 1 ]]; then
						if [[ `cat ~/.guarangoradio/data/tmp/pisador` = 1 ]]; then 
						avanti=`echo "$randomfile"|grep -i avance`
							if [ "$avanti" = "" ]; then 
								if [[  $line != "Hora" ]]; then 
								xterm -iconic  -fg Black -bg Yellow -title "Pisador" -geometry 40x1+0+0 -e ~/.guarangoradio/data/panel/pisador.sh & 
								fi
							fi
						fi  

						minini=`date  +%-M`
						echo $randomfile > ~/.guarangoradio/data/tmp/repite
						echo "#!/bin/bash" > ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "killall -9 countdown.sh" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "~/.guarangoradio/bin/countdown.sh &" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  $srtopcion -af volnorm \"$randomfile\"" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "sleep 0.5" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "echo "0" > ~/.guarangoradio/data/tmp/repitiendo" >> ~/.guarangoradio/data/tmp/repitetmp.sh



						chmod 755 ~/.guarangoradio/data/tmp/repitetmp.sh

						tiempo "$randomfile"
					 	killall -9 countdown.sh
						sleep 0.2
						~/.guarangoradio/bin/countdown.sh &
						#xterm -iconic  -fg Green -bg DarkBlue -title "$nombrebase"  -geometry 40x1-0+0 -e 
						mplayer $tvopcion $srtopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  -af volnorm -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile" > /dev/null 2>&1 &
				logo=`cat ~/.guarangoradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.guarangoradio/bin/logopersiste.sh &
				fi
						ruta=`echo "$randomfile"|sed s/"\/$nombrebase"//g`
						echo "$nombrebase" >> "$ruta"/.historico.mus
						echo "ruta" $ruta
						previo="$randomfile"
						#sleep 2
						~/.guarangoradio/bin/cartucho.sh &

						sleep 1			
						sed -i "1d" ~/.guarangoradio/data/tmp/playlist
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
						echo randomfile $randomfile

						


						tiempo "$randomfile"
						minfin=`echo $(($minini + $segundos/60))`
						hfin=`echo $((($hini*60+$minfin)/60))`	
						echo "minini:" $minini "minfin:" $minfin "hfin:" $hfin
						mix=`cat ~/.guarangoradio/data/mix.txt`
						mezcla=`echo $segundos - $mix|bc`
						echo "mezcla a" $mezcla "segundos"
						.  ~/.guarangoradio/bin/panico.sh &
						~/.guarangoradio/bin/cartucho.sh &

						sleep $mezcla
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.guarangoradio/bin/detenermanual.sh
fi


					else 

						if [[ `cat ~/.guarangoradio/data/tmp/pisador` = 1 ]]; then  
				
						avanti=`echo "$randomfile"|grep -i avance`
							if [ "$avanti" = "" ]; then 				
							xterm -iconic  -fg Black -bg Yellow -title "Pisador" -geometry 40x1+0+0 -e ~/.guarangoradio/data/panel/pisador.sh & 
							fi
						fi  
						minini=`date  +%-M`
						sed -i "1d" ~/.guarangoradio/data/tmp/playlist
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
						tiempo "$randomfile"
						echo randomfile $randomfile
						~/.guarangoradio/bin/cartucho.sh &
						killall -9 countdown.sh
						~/.guarangoradio/bin/countdown.sh &
						#xterm -iconic  -fg Green -bg DarkBlue -title "$nombrebase" -geometry 40x1-0+0 -e 
						mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  $srtopcion -af volnorm  -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1
				logo=`cat ~/.guarangoradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.guarangoradio/bin/logopersiste.sh &
				fi
						previo="$randomfile"
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.guarangoradio/bin/detenermanual.sh
fi

					fi 
				else
					echo "parece que $randomfile no existe"
						sed -i "1d" ~/.guarangoradio/data/tmp/playlist
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
				fi
			fi

			musfin=`date +%s`
			duramus=$(($musfin-$musini))
			if [ -s ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m` ]; then
			touch ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m`
			fi
			echo `date +%Y-%d-%m-%H:%M`, $randomfile, $duramus segundos >> ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m`.txt #Reporte comerciales



echo $mix > ~/.guarangoradio/data/mix			
			minfin=`date  +%-M`
			hfin=`date +%-H`

espera=`cat ~/.guarangoradio/data/tmp/stop`
repitiendo=`cat ~/.guarangoradio/data/tmp/repitiendo`

while [[ $repitiendo = 1 ]]; do
echo "GR repitiendo: $nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt
echo "Gr repitiendo: $nombrebase" > ~/CurrentSong.txt
sleep 1
repitiendo=`cat ~/.guarangoradio/data/tmp/repitiendo`
done

if [[ $espera = 1 ]]; then
~/.guarangoradio/bin/detenermanual.sh
fi

#while [[ $espera = 1 ]]; do
#echo "Detenido...... Presione Play para pasar a modo automático" > ~/.guarangoradio/data/tmp/currentsong.txt
#echo "Detenido...... Presione Play para pasar a modo automático" > ~/CurrentSong.txt
#sleep 1
#espera=`cat ~/.guarangoradio/data/tmp/stop`
#done

########################################INICIO EVENTOS
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.guarangoradio/bin/detenermanual.sh
fi
	
	echo "+++++++++Inicio Reproducción Eventos++++++++++++++++"
		cnelineas=`grep -c $ ~/.guarangoradio/data/tmp/eventoslist`
		if [ -s ~/.guarangoradio/data/tmp/eventoslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 
					twitter=`cat ~/.guarangoradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo Eventos"|twidge update &
					fi

			
while [[ $cnelineas -ge 1 ]]; do
	comercial="`head -1 ~/.guarangoradio/data/tmp/eventoslist`"
	#comercial=`sed -n 1p ~/.guarangoradio/data/tmp/eventoslist`
	echo "comercial:" $comercial
	nombrebase=$comercial  #`echo "$comercial" |awk -F/ '{print $NF}'`
	comini=`date +%s`
	echo "Evento: $nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt;
	echo "Evento: $nombrebase" > ~/CurrentSong.txt
	echo "Evento: $nombrebase" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
	echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb;
	sed -i "1d" ~/.guarangoradio/data/tmp/eventoslistweb
	sed -i "1d" ~/.guarangoradio/data/tmp/eventoslistwebg3
			sleep 0.2
			killall -9 countdown.sh
			
		#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 

		internet=`echo "$comercial"|grep "http://"`
		echo "$comercial" > ~/.guarangoradio/data/tmp/tmpweb
		ejecutar=`echo $comercial|grep 123456789098765432100`
		comando=`echo $comercial|awk -F"&&" '{print $2}'`
		echo "comando" $comando 

		if [[ $internet != "" ]]; then
			echo "00:00:"`echo "$comercial"|awk '{print $4}'`  > ~/.guarangoradio/data/tmp/duracion
			~/.guarangoradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.guarangoradio/data/tmp/slave.txt $comercial #> /dev/null 2>&1 &
			previo="$comercial"
			sed -i "1d" ~/.guarangoradio/data/tmp/eventoslist
		else		
			if [[ $ejecutar = "" ]]; then
			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.guarangoradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$comercial" > /dev/null 2>&1 &
			sed -i "1d" ~/.guarangoradio/data/tmp/eventoslist
			cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.guarangoradio/data/tmp/fundidocomerciales`
			espera=$(($segundos-$fundidocom))
			sleep $espera

			previo="$comercial"
			else
			source $comando
			fi
		fi
				



	#sed -i "1d" ~/.guarangoradio/data/tmp/eventoslist
	cnelineas=`grep -c $ ~/.guarangoradio/data/tmp/eventoslist`
	echo "cnelineas:" $cnelineas

	comfin=`date +%s`
	duracion=$(( $comfin - $comini ))


				if [ -s ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
				touch ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`
				fi
				echo `date +%Y-%d-%m-%H:%M`, "$comercial", $duracion segundos >> ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

done
		fi
		#echo "0" >  ~/.guarangoradio/data/tmp/desiguiente
		
	#if [[ $iniespaciop = 3 ]]; then
	#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
	#fi

echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
echo "+++++++++Fin Reproducción Eventos++++++++++++++++"
################################### FIN EVENTOSS #####################################

########################################INICIO COMERCIALES
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.guarangoradio/bin/detenermanual.sh
fi
	
	echo "+++++++++Inicio Reproducción Comerciales++++++++++++++++"
		iniespaciop=`cat ~/.guarangoradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
		if [ -s ~/.guarangoradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 
			desiguiente=`cat ~/.guarangoradio/data/tmp/desiguiente`
			if [[ $desiguiente = 0 ]]; then
			sleep $(($mix-1))
			fi

			if [[ $iniespaciop = 1 ]]; then
			~/.guarangoradio/data/panel/playinicioespacio.sh #xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
			iniespaciop=3
			fi
					twitter=`cat ~/.guarangoradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
			echo "Ahora emitiendo Comerciales"|twidge update &
#			xterm -iconic  -fg Green -bg DarkBlue -title "Clima" -geometry 40x1-0+0  -e ~/.guarangoradio/bin/tiempo-clima.sh &
					fi

while [[ $cnlineas -ge 1 ]]; do

			comercial="`head -1 ~/.guarangoradio/data/tmp/comercialeslist`"

			#comercial=`sed -n 1p ~/.guarangoradio/data/tmp/comercialeslist`

			nombrebase=`echo "$comercial" |awk -F/ '{print $NF}'`
			comini=`date +%s`
			echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt;
			echo "$nombrebase" > ~/CurrentSong.txt
			echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb;
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistwebg3
			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.guarangoradio/bin/countdown.sh &
				#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
				
				mplayer -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo  $tvopcion -af volnorm -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$comercial"  > /dev/null 2>&1 &


				previo="$comercial"

			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
			cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.guarangoradio/data/tmp/fundidocomerciales`
			espera=$(($segundos-$fundidocom))
			sleep $espera



			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))


						if [ -s ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$comercial", $duracion segundos >> ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			espera=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			while [[ $espera = 1 ]]; do
			echo "Detenido Comerciales...... Presione Play para pasar a modo automático" > ~/.guarangoradio/data/tmp/currentsong.txt
			sleep 1
			espera=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			done
done
		fi
		echo "0" >  ~/.guarangoradio/data/tmp/desiguiente
		
	if [[ $iniespaciop = 3 ]]; then
	~/.guarangoradio/data/panel/playfinespacio.sh #xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
	fi

echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"
################################### FIN COMERCIALES #####################################

nlinea=$(($nlinea+1))
echo "nlinea" $nlinea	
done 

#Si no hay lista 
else
 
sleep 3
fi	
hora1=`date  +%-H`
saliolazo=1
echo "saliolazo" $saliolazo

done
echo "final"
done
