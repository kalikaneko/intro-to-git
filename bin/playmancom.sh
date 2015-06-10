#!/bin/bash

########################################INICIO COMERCIALES MANUAL
#. ~/.guarangoradio/bin/comercialplay.sh 	

function tiempo() {
echo "funciontiempo en playcom.sh"
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
		

	echo "+++++++++Inicio Reproducción Comerciales++++++++++++++++"
		
espera=`cat ~/.guarangoradio/data/tmp/stop`
if [[ $espera = 1 ]]; then
		iniespaciop=`cat ~/.guarangoradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
		if [ -s ~/.guarangoradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

			#sleep $(($mix-2))
			if [[ $iniespaciop = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi

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

		while [ $cnlinea -le $cnlineas ]; 
		do 
		cline="`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/comercialeslist`" 
		cline1=`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/comercialeslist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.guarangoradio/data/tmp/comercialeslist`
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistwebg3
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`

			comini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$randomfile" > ~/.guarangoradio/data/tmp/currentsong.txt;
			echo "$randomfile" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb;

			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.guarangoradio/bin/countdown.sh &
				#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 


				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo $srtopcion -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1 &


			previo="$comercial"

			#sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
			cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.guarangoradio/data/tmp/fundidocomerciales`
			espera=$((segundos-$fundidocom))
			echo "espera" $espera
			sleep $espera


			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			
			if [[ $iniespaciop = 3 ]]; then
			if [[ $esperacom = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
			if [[ $espera = 1 ]]; then
			echo "Detenido...... Presione Play para pasar a modo automático" > ~/.guarangoradio/data/tmp/currentsong.txt
			fi
			echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			exit 0
			fi
			fi
						
		cnlinea=$(($cnlinea+1))
		echo "cnlinea" $cnlinea
	
		done 
		
		#minfin=`date  +%-M`
		#hfin=`date +%-H`
#		echo "===Dispara CargaComercial====== con minini:" $minini "minfin:" $minfin "hfin:" $hfin
#		. ~/.guarangoradio/bin/cargacomercial.sh &
		echo "=============Fin Comerciales==================="
		fi
		#fi de comerciales

		
		if [[ $iniespaciop = 3 ]]; then
		xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
		fi
		echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
		echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"
fi

modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.guarangoradio/bin/guarangoauto.sh
fi


modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 0 ]]; then

echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
killall -9 panico.sh
killall -9 gmplayer
killall -9 mplayer
killall -9 sleep
killall -9 countdown.sh
killall -9 guarangoauto.sh
echo "00:00:00" > ~/.guarangoradio/data/tmp/avance
		iniespaciop=`cat ~/.guarangoradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`

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


		if [ -s ~/.guarangoradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

			#sleep $(($mix-2))
			if [[ $iniespaciop = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi

		while [ $cnlineas -ge 1 ]; 
		do 
		cline="`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/comercialeslist`" 
		cline1=`sed -n $cnlinea"p" ~/.guarangoradio/data/tmp/comercialeslist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.guarangoradio/data/tmp/comercialeslist`
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslistwebg3
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`

			comini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$randomfile" > ~/.guarangoradio/data/tmp/currentsong.txt;
			echo "$randomfile" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.guarangoradio/data/tmp/currentsongweb;

			tiempo "$randomfile"
			~/.guarangoradio/bin/countdown.sh &

				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 $tvopcion -vf bmovl=0:0:~/.guarangoradio/data/tmp/logo.fifo $srtopcion -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1 &


			previo="$comercial"

			#sed -i "1d" ~/.guarangoradio/data/tmp/comercialeslist
			cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.guarangoradio/data/tmp/fundidocomerciales`
			espera=$((segundos-$fundidocom))
			echo "espera" $espera
			sleep $espera

			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			
			if [[ $iniespaciop = 3 ]]; then
			if [[ $esperacom = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
			if [[ $espera = 1 ]]; then
			echo "Detenido...... Presione Play para pasar a modo automático" > ~/.guarangoradio/data/tmp/currentsong.txt
			fi
			echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
			exit 0
			fi
			fi
		cnlineas=`grep -c $ ~/.guarangoradio/data/tmp/comercialeslist`				
		#cnlinea=$(($cnlinea+1))
		#echo "cnlinea" $cnlinea
	
		done 
		
		#minfin=`date  +%-M`
		#hfin=`date +%-H`
#		echo "===Dispara CargaComercial====== con minini:" $minini "minfin:" $minfin "hfin:" $hfin
#		. ~/.guarangoradio/bin/cargacomercial.sh &
		echo "=============Fin Comerciales==================="
		fi
		#fi de comerciales

		
		if [[ $iniespaciop = 3 ]]; then
		xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
		fi
		echo "Visor de Comerciales" > ~/.guarangoradio/data/tmp/currentcomercial.txt;
		echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"
fi
echo "Modo Manual" > ~/.guarangoradio/data/tmp/currentsong.txt;
echo "00:00:00" > ~/.guarangoradio/data/tmp/avance
modo=`cat ~/.guarangoradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.guarangoradio/bin/guarangoauto.sh
fi


################################### FIN COMERCIALES #####################################
