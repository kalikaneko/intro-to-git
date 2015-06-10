#!/bin/bash
function comercialplay() {
	echo "Ejecuta funcioncomercialplay"
	duracionacumulada=0
if [[ $evento = 1 ]]; then
carpeta="eventos"
else
if [[ $evento = 0 ]]; then
carpeta="comerciales"
fi
fi
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
			if [[ $evento = 1 ]]; then

				comercialbase=`echo "${data[0]}"|awk -F/ '{print $NF}'`
				echo "${data[0]}" >> ~/.guarangoradio/data/tmp/eventoslist
				echo "<font size=1 color=yellow>$comercialbase</font>" >> ~/.guarangoradio/data/tmp/eventoslistweb
				echo "$comercialbase" >> ~/.guarangoradio/data/tmp/eventoslistwebg3 
				echo "CargalistaPlay..................."
				#gmplayer  "${data[0]}"
				#tiempo  "${data[0]}"
				echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com

				


			else
   					
				comercialbase=`echo "${data[0]}"|awk -F/ '{print $NF}'`
				echo "${data[0]}" >> ~/.guarangoradio/data/tmp/comercialeslist
				echo "<font size=1 color=yellow>$comercialbase</font>" >> ~/.guarangoradio/data/tmp/comercialeslistweb
				echo "$comercialbase" >> ~/.guarangoradio/data/tmp/comercialeslistwebg3 
				echo "CargalistaPlay..................."
				#gmplayer  "${data[0]}"
				#tiempo  "${data[0]}"
				echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com
			fi
		fi				
	done < ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com
}

infinito=1
while [ $infinito = 1 ]; do
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
segundo=`date +%-S`

while [ $segundo -lt 55 ]; do
sleep 2
segundo=`date +%-S`
done
echo "minuto" $minuto "segundo" $segundo

			evento=0

			minutocarga=$(($minuto+1))
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.guarangoradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				echo "va a while en la misma hora"
				comercialplay
				fi
			else 
				echo "va a while en la misma hora"
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))			
				if [ -s ~/.guarangoradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				comercialplay
				fi								
			fi
			evento=0
			minutocarga=$(($minuto+1))
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				echo "va a while en la misma hora"
				comercialplay
				fi
			else 
				echo "va a while en la misma hora"
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))			
				if [ -s ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				comercialplay
				fi								
			fi
cnelineas=`grep -c $ ~/.guarangoradio/data/tmp/eventoslist`
if [[ $cnelineas -ge 1 && $saltar = 0 ]]; then
sleep 5
~/.guarangoradio/bin/siguiente.sh
saltar=1
fi
	while [[ $minuto = `date +%-M` ]]; do
	sleep 3
	done
done
