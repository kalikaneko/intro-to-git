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

########################################REPRODUCE PLAYLIST MANUALMENTE

	echo "+++++++++Inicio Reproducción++++++++++++++++"

function tiempo() {
echo "funciontiempo en playmus.sh"
duracion=`avconv -i "$1"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'` 
echo "$duracion" > ~/.guarangoradio/data/tmp/duracion
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
		
#modo=`cat ~/.guarangoradio/data/tmp/modo`
#if [[ $modo = 0 ]]; then
echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
killall -9 panico.sh
killall -9 gmplayer
killall -9 mplayer
killall -9 sleep
killall -9 countdown.sh
killall -9 guarangoauto.sh
echo "00:00:00" > ~/.guarangoradio/data/tmp/avance

		cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/playlist`
		if [[ $cnlineas -ge 1 ]]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

		#while [ $cnlinea -le $cnlineas ]; 
		#do 



		cline="`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/playlist`" 
		cline1=`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/playlist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.guarangoradio/data/tmp/playlist`
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

	if [[ $randomfile = "Hora"  ]];
				then	
					nombrebase="Hora"
					echo "Hora" > ~/.guarangoradio/data/tmp/currentsong.txt 
					echo "Hora" ~/.guarangoradio/data/tmp/currentsongweb
					echo "Hora" ~/CurrenSong.txt
					killall -9 countdown.sh
					echo "Hora" > ~/.guarangoradio/data/tmp/avance
					echo "<font color='red' size='24'><b>Hora</b></font>" > ~/.guarangoradio/data/tmp/avanceweb
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
						echo randomfile $randomfile

					xterm -iconic  -fg Green -bg DarkBlue -title "hora" -geometry 40x1-0+0  -e ~/.guarangoradio/data/panel/hora.sh

						sed -i "1d" ~/.guarangoradio/data/tmp/playlist
						sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
						desiguiente=0

			else

				logo=`cat ~/.guarangoradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.guarangoradio/bin/logopersiste.sh &
				fi

			sed -i "1d" ~/.guarangoradio/data/tmp/playlist
			sed -i "1d" ~/.guarangoradio/data/tmp/playlistg3
			sed -i "1d" ~/.guarangoradio/data/tmp/playlistweb
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
			tiempo "$randomfile"
			~/.guarangoradio/bin/countdown.sh &
			~/.guarangoradio/bin/cartucho.sh &

			musini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt;
			# echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb;

						echo $randomfile > ~/.guarangoradio/data/tmp/repite
						echo "#!/bin/bash" > ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "killall -9 countdown.sh" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "~/.guarangoradio/bin/countdown.sh &" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo $srtopcion -af volnorm   \"$randomfile\"" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "sleep 0.5" >> ~/.guarangoradio/data/tmp/repitetmp.sh
						echo "echo "0" > ~/.guarangoradio/data/tmp/repitiendo" >> ~/.guarangoradio/data/tmp/repitetmp.sh



						chmod 755 ~/.guarangoradio/data/tmp/repitetmp.sh


				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo $srtopcion -af volnorm -slave  -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile" 
				
			musfin=`date +%s`
			duracion=$(( $musfin - $musini ))
						if [ -s ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m` ]; then
						touch ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.guarangoradio/data/reporte/parrilla-`date +%Y-%d-%m`.txt #Reporte parrilla


		fi
	fi
		

		echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
		echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentsong.txt;
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.guarangoradio/bin/guarangoauto.sh
fi


################################### FIN PLAYLIST #####################################
