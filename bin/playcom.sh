########################################INICIO COMERCIALES MANUAL
#. ~/.guarangoradio/bin/comercialplay.sh 	
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
				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 -slave -input file=~/.guarangoradio/data/tmp/slave.txt  "$randomfile" 
			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.guarangoradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			
			if [[ $iniespaciop = 3 ]]; then
			if [[ $espera = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playfinespacio.sh
			fi
			fi

			while [[ $esperacom = 1 ]]; do
			echo "Detenido...... Presione PlayComerciales para continuar reproduciendo" > ~/.guarangoradio/data/tmp/currentcomercial.txt
			sleep 1
			esperacom=`cat ~/.guarangoradio/data/tmp/stopcomercial`
			if [[ $iniespaciop = 1 ]]; then
			if [[ $espera = 0 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.guarangoradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi
			fi
			done
						
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
################################### FIN COMERCIALES #####################################
