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
 
#Reporte de Emisiones

opcion=$(dialog --stdout --checklist  "Reporte de emisiones GR" 50 40 40 1 "Comerciales" off 2 "Parrilla" off)
opcion=`echo $opcion|sed 's/\"//g'`

        for opcion in $opcion
        do
               if [ "$opcion" = "1" ];
                     then 
                      opcion="Comerciales"
               elif [ "$opcion" = "2" ]
                     then
                      opcion="Parrilla"
		fi
	done
	
	 
	Y=`date +%Y`
	YP=$(($Y-1))
	YN=$(($Y+1)) 

anio=$(dialog --stdout --checklist  "Seleccione el Año" 50 40 40 1 "$YP" off 2 "$Y" on 3 "$YN" off )
anio=`echo $anio|sed 's/\"//g'`
echo $anio
					for anio in $anio
					do
						if [ "$anio" = "1" ];
						     then 
						     A[0]=$YP

						elif [ "$anio" = "2" ];
						     then 
						     A[1]=$Y

						elif [ "$anio" = "3" ];
						     then 
						     A[2]=$YN		
					       fi
					done
				
	###
#echo "a0"${A[0]} "a1"${A[1]} "a2"${A[2]}

mes=$(dialog --stdout --checklist  "Seleccione el Año" 50 40 40 1 "Enero" off 2 "Febrero" off 3 "Marzo" off 4 "Abril" off 5 "Mayo" off 6 "Junio" off 7 "Julio" off 8 "Agosto" off 9 "Septiembre" off 10 "Octubre" off 11 "Noviembre" off 12 "Diciembre" off )

mes=`echo $mes|sed 's/\"//g'`
	 

		for mes in $mes
		do
		       if [ "$mes" = "1" ];
		             then 
		              rango[1]=01
		       elif [ "$mes" = "2" ]
		             then
		              rango[2]=02
		      
		       elif [ "$mes" = "3" ]
		             then
		              rango[3]=03
	 
		       elif [ "$mes" = "4" ]
		             then
		              rango[4]=04

		       elif [ "$mes" = "5" ]
		             then
		              rango[5]=05

		       elif [ "$mes" = "6" ]
		             then
		              rango[6]=06

		       elif [ "$mes" = "7" ]
		             then
		              rango[7]=07

		       elif [ "$mes" = "8" ]
		             then
		              rango[8]=08

		       elif [ "$mes" = "9" ]
		             then
		              rango[9]=09

		       elif [ "$mes" = "10" ]
		             then
		              rango[10]=10

		       elif [ "$mes" = "11" ]
		             then
		              rango[11]=11

		       elif [ "$mes" = "12" ]
		             then
		              rango[12]=12              

		       fi
		done
	###

#Reporte de comerciales 
if [ $opcion = Comerciales ]; then
buscar=$(dialog --stdout --inputbox "Ingrese parte del nombre del comercial" 10 30)

###
#Generación del archivo comerciales.txt
archivo=~/.guarangoradio-shell/data/reporte/reporte-`date +%Y-%h-%Hh%Mm.txt`
touch $archivo 
ii=0
while [ $ii -le 2 ]; do
jj=1
while [ $jj -le 12 ]; do
grep -i "$buscar" ~/.guarangoradio-shell/data/reporte/comercial-${A[$ii]}-??-${rango[$jj]}.txt >> $archivo
jj=$(($jj+1))
done
ii=$(($ii+1))
done
cat $archivo > ~/reporte.txt		
clear
cat ~/reporte.txt
fi 

#Reporte de parrilla 
if [ $opcion = Parrilla ]; then
buscar=$(dialog --stdout --inputbox "Ingrese parte del nombre del audio" 10 30)
###
#Generación del archivo parrilla-emitida.txt
archivo=~/.guarangoradio-shell/data/reporte/parrilla-emitida-`date +%Y-%h-%Hh%Mm.txt`
touch $archivo
ii=0
while [ $ii -le 2 ]; do
jj=1
while [ $jj -le 12 ]; do
grep -i "$buscar" ~/.guarangoradio-shell/data/reporte/parrilla-${A[$ii]}-??-${rango[$jj]}.txt >> $archivo
jj=$(($jj+1))
done
ii=$(($ii+1))
done
cat $archivo > ~/reporte.txt		
clear
cat ~/reporte.txt	
fi 
~/.guarangoradio-shell/bin/guarango-gui.sh
