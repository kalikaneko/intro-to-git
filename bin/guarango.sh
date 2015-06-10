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
echo "Guarango Radio -v:alfalfa"
echo $$ > ~/.guarangoradio-shell/data/pid
~/.guarangoradio-shell/bin/guarango-gui.sh &
#Reproducir desde la parrilla
#Determinar dia de la semana y hora
salir=0
while [ $salir=0 ]; do
minini=`date  +%-M`
hini=`date +%-H`
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
echo `date`
#Tema aleatorio según la parrilla
##Aleatorio según las lineas ~/.guarangoradio-shell/data/parrilla/dia/ranura
##ranura por horas, probablemente debería ser cada 20 o 30 minutos

##Determinar el número de lineas de la ranura
ranura=`echo "$hora-$(($hora+1)).mus"`
nlineas=`grep -c $ ~/.guarangoradio-shell/data/parrilla/$dia/$ranura`
hora1=`date  +%-H` 

while [ $hora = $hora1 ]; do
		echo ranura $ranura 
		if [ -s ~/.guarangoradio-shell/data/parrilla/$dia/$ranura ]; then		
		nlinea=1 
		while [ $nlinea -le $nlineas ]; 
		do 
		line="`sed -n $nlinea"p" ~/.guarangoradio-shell/data/parrilla/$dia/$ranura`" 
		line1=`sed -n $nlinea"p" ~/.guarangoradio-shell/data/parrilla/$dia/$ranura` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			line=`echo -e "${line}"|sed  s/\'//g`
			line=`echo -e "${line}"|sed  s/" "/"\\\\ "/g`
					
			#Random
			#Contruye un script temporal para ejecutarlo, porque el arreglo no acepta los
			#datos desde una variable :(  files=($variable) donde la variable es un path
			#de una carpeta de música con archivos de audio
			echo '#!/bin/bash' > ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'files=('`echo $line|sed s/" "/"\\\\\ "/g`')' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'N=${#files[@]}' >> ~/.guarangoradio-shell/data/tmp/linea.tmp   
			echo '((N=RANDOM%N))' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'randomfile=${files[$N]}' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'echo randomfile $randomfile' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'if [[ $randomfile = "Hora" ]];' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'then' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo '~/.guarangoradio-shell/data/panel/hora.sh' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'else' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'musini=`date +%s`' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo '/usr/bin/mpg321   "$randomfile"' >> ~/.guarangoradio-shell/data/tmp/linea.tmp 
			echo 'musfin=`date +%s`' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'duramus=$(($musfin-$musini))' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'if [ -s ~/.guarangoradio-shell/data/reporte/parrilla-`date +%Y-%d-%m` ]; then' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'touch ~/.guarangoradio-shell/data/reporte/parrilla-`date +%Y-%d-%m`' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'fi' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'echo `date +%Y-%d-%m-%H:%M`, $randomfile, $duramus segundos >> ~/.guarangoradio-shell/data/reporte/parrilla-`date +%Y-%d-%m`.txt #Reporte comerciales' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			echo 'fi' >> ~/.guarangoradio-shell/data/tmp/linea.tmp
			#echo '/usr/bin/mpg321 -minigui  "$randomfile"' >> ~/.guarangoradio-shell/data/tmp/linea.tmp 			
			~/.guarangoradio-shell/data/tmp/linea.tmp
			minfin=`date  +%-M`
			hfin=`date +%-H`
. ~/.guarangoradio-shell/bin/comercialplay.sh 	

		nlinea=$(($nlinea+1))
		echo $nlinea
	
		done 
		fi
		hora1=`date  +%"H"`
done
echo "final"
done
