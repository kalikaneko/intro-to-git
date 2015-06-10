#!/bin/bash
function comercialplay() {
	echo "Ejecuta funcioncomercialplay"
	#duracionacumulada=0
if [[ $evento = 1 ]]; then
	carpeta="eventos"
else
	if [[ $evento = 0 ]]; then
		carpeta="comerciales"
		else 
		carpeta="noexiste"
	fi	
fi

acciones=`grep -c $ ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com`
accion=1
	while [[ $accion -le $acciones ]]; do
	action="`sed -n $accion"p" ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com`"   					




	actionbase=`echo "$action"|awk -F"|" '{print $1}'`
	habil=`echo "$action"|awk -F"|" '{print $2}'|grep $dia`
	inicio=`echo "$action"|awk -F"|" '{print $3}'`
	final=`echo "$action"|awk -F"|" '{print $4}'`
	now=`date +%Y%m%d` 

			if [ -d "$actionbase" ]; then
				comercialrandom=`/bin/ls -1 "$actionbase" | sort --random-sort | head -1`
#				ruta=`readlink --canonicalize "$actionbase/$comercialrandom"` # Converts to full path
				ruta="$actionbase/$comercialrandom"
				nombrebase=`echo "$ruta" |awk -F/ '{print $NF}'`
				extension="${nombrebase##*.}"
				validado=`grep -i $extension ~/.guarangoradio/data/extensiones`
				if [ "$validado" != "" ]; then
				echo "ruta: " $ruta
				actionbase="$ruta"
				else
				zenity --warning --text="El archivo seleccionado parece no ser de audio"
				fi 
			fi

	if [[ "$actionbase" != "" ]]; then
		if [[ $now -ge $inicio && $now -le $final  && $habil -gt 0 ]]; then  

			if [[ $evento = 1 ]]; then
				nbaseev=`echo "$actionbase"|awk -F/ '{print $NF}'`
				echo "$actionbase" >> ~/.guarangoradio/data/tmp/eventoslist
				echo "<font size='1' color='blue'><b>$nbaseev</b></font>" >> ~/.guarangoradio/data/tmp/eventoslistweb
				duracion=`avconv -i "$actionbase"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'`
				echo "$nbaseev" "["$duracion"]" >> ~/.guarangoradio/data/tmp/eventoslistwebg3 
				echo "CargalistaEventos..................."
				#echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com

			else #evento =1
				if [[ $evento = 0 ]]; then
				nbasecom=`echo "$actionbase"|awk -F/ '{print $NF}'`
				echo "$actionbase" >> ~/.guarangoradio/data/tmp/comercialeslist
				echo "<font size='1' color='blue'><b>$nbasecom</b></font>" >> ~/.guarangoradio/data/tmp/comercialeslistweb
				duracion=`avconv -i "$actionbase"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'`
				echo "$nbasecom" "["$duracion"]" >> ~/.guarangoradio/data/tmp/comercialeslistwebg3 
				echo "CargalistaComerciales..................."
				#echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.guarangoradio/data/$carpeta/$hora/$minutocarga.com
				fi #evento=0
			fi #evento=1
		fi #now
	fi #actionbase !=""
	accion=$(($accion+1))
	done #accion -le acciones
}

infinito=1
while [ $infinito = 1 ]; do
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
segundo=`date +%-S`



if [[ $minuto -eq 0 ]]; then
sleep 1
ranura=`echo "$hora-$(($hora+1)).mus"`
ranuraprevia=`echo "$(($hora-1))-$hora.mus"`

secuencia=`diff ~/.guarangoradio/data/parrilla/$dia/$ranura ~/.guarangoradio/data/parrilla/$dia/$ranuraprevia`
echo "secuencia" $secuencia
#Vaciar playlist por cambio de parrilla
if [[ "$secuencia" != "" ]]; then
echo "vacio la lista por cambio de parrilla"
~/.guarangoradio/bin/vaciarlista.sh
sleep 1
~/.guarangoradio/bin/vaciarlista.sh
sleep 3 #tiempo para cargar playlist
else
echo "dejar una linea en playlist ¿..?"
fi
fi


while [ $segundo -lt 5 ]; do
sleep 2
segundo=`date +%-S`
done
echo "minuto" $minuto "segundo" $segundo

			evento=0

			minutocarga=$(($minuto+1))
			echo "minutocarga" $minutocarga
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.guarangoradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				echo "evento en la misma hora"
				echo "coincidencia apriori en" ~/.guarangoradio/data/eventos/$hora/$minutocarga.com
				comercialplay
				fi
			else 
				
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))			
				if [ -s ~/.guarangoradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				echo "evento en la siguiente hora"
				echo "coincidencia apriori en" ~/.guarangoradio/data/eventos/$hora/$minutocarga.com
				comercialplay
				fi								
			fi
			evento=0
			#minutocarga=$(($minuto+1))
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				echo "comercial en la misma hora"
				echo "coincidencia apriori en" ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com
				comercialplay
				fi
			else 				
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))	
				echo "~/.guarangoradio/data/comerciales/$hora/$minutocarga.com"		
				if [ -s ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				comercialplay
				echo "comercial en la siguiente hora"
				echo "coincidencia aprior en" ~/.guarangoradio/data/comerciales/$hora/$minutocarga.com
				fi								
			fi
cnelineas=`grep -c $ ~/.guarangoradio/data/tmp/eventoslist`
if [[ $cnelineas -ge 1 && $saltar = 0 ]]; then
sleep 57
~/.guarangoradio/bin/siguiente.sh
saltar=1
while [[ $cnelineas -ge 1 ]]; do
sleep 5
cnelineas=`grep -c $ ~/.guarangoradio/data/tmp/eventoslist`
done
fi
	while [[ $minuto = `date +%-M` ]]; do
	sleep 3
	done
done
