#!/bin/bash 
#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 18-Ene-2012		    #
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


listo=0
         while [  $listo -ne 1000 ]; do

#Para programar comerciales con fecha inicio fin -- pendiente

pautaini=$(dialog --stdout --title "Fecha de Inicio" --calendar "Seleccione una fecha" 0 0 )
			IFS="/"
			n=0
			for WORD in $pautaini
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "

pautaini=${data[2]}${data[1]}${data[0]}
#echo $pautaini

pautafin=$(dialog --stdout --title "Fecha de Finalizacion" --calendar "Seleccione una fecha" 0 0 )
			IFS="/"
			n=0
			for WORD in $pautafin
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "

pautafin=${data[2]}${data[1]}${data[0]}

#echo $pautafin

##########################
diasemit=$(dialog --stdout --checklist  "Seleccione los días de pautaje" 50 40 40 1 lunes on 2 martes on 3 miércoles on 4 jueves on 5 viernes on 6 sábado on 7 domingo on)

diasemite=`echo $diasemit|sed 's/\ //g'|sed 's/\"//g'`



opcionaa=$(dialog --stdout --checklist  "Seleccione la Horas de Pautaje" 50 40 60 0 0:00 off 1 01:00 off 2 02:00 off 3 03:00 off 4 04:00 off 5 05:00 on 6 06:00 on 7 07:00 on 8 08:00 on 9 09:00 on 10 10:00 on 11 11:00 on 12 12:00 on 13 13:00 on 14 14:00 on 15 15:00 on 16 16:00 on 17 17:00 on 18 18:00 on 19 19:00 on 20 20:00 on 21 21:00 off 22 22:00 off 23 23:00 off)

opcion=`echo $opcionaa|sed 's/\"//g'`
echo $opcion

        for opcion in $opcion
        do
               if [ "$opcion" = "0" ];
                     then 
                      hr[0]=1
               elif [ "$opcion" = "1" ]
                     then
                      hr[1]=1
              
               elif [ "$opcion" = "2" ]
                     then
                      hr[2]=1
 
               elif [ "$opcion" = "3" ]
                     then
                      hr[3]=1

               elif [ "$opcion" = "4" ]
                     then
                      hr[4]=1

               elif [ "$opcion" = "5" ]
                     then
                      hr[5]=1


               elif [ "$opcion" = "6" ]
                     then
                      hr[6]=1


               elif [ "$opcion" = "7" ]
                     then
                      hr[7]=1


               elif [ "$opcion" = "8" ]
                     then
                      hr[8]=1


               elif [ "$opcion" = "9" ]
                     then
                      hr[9]=1


               elif [ "$opcion" = "10" ]
                     then
                      hr[10]=1


               elif [ "$opcion" = "11" ]
                     then
                      hr[11]=1


               elif [ "$opcion" = "12" ]
                     then
                      hr[12]=1


               elif [ "$opcion" = "13" ]
                     then
                      hr[13]=1


               elif [ "$opcion" = "14" ]
                     then
                      hr[14]=1


               elif [ "$opcion" = "15" ]
                     then
                      hr[15]=1


               elif [ "$opcion" = "16" ]
                     then
                      hr[16]=1


               elif [ "$opcion" = "17" ]
                     then
                      hr[17]=1


               elif [ "$opcion" = "18" ]
                     then
                      hr[18]=1


               elif [ "$opcion" = "19" ]
                     then
                      hr[19]=1


               elif [ "$opcion" = "20" ]
                     then
                      hr[20]=1


               elif [ "$opcion" = "21" ]
                     then
                      hr[21]=1


               elif [ "$opcion" = "22" ]
                     then
                      hr[22]=1


               elif [ "$opcion" = "23" ]
                     then
                      hr[23]=1



               fi
        done
        
       
echo $diasemite


opcionmm=$(dialog --stdout --checklist  "Seleccione los minutos de reproducción" 50 40 60 0 "00 minutos" off 5 "05 minutos" 0ff 10 "10 minutos" off 15 "15 minutos" off 20 "20 minutos" off 25 "25 minutos" off 30 "30 minutos" off 35 "35  minutos" off 40 "40 minutos" off 45 "45 minutos" off 50 "50 minutos" off 55 "55 minutos" off )

opcion=`echo $opcionmm|sed 's/\"//g'`
      
        for opcion in $opcion
        do
               if [ "$opcion" = "0" ];
                     then 
                      mn[0]=1
               elif [ "$opcion" = "5" ]
                     then
                      mn[5]=1
              
               elif [ "$opcion" = "10" ]
                     then
                      mn[10]=1
 
               elif [ "$opcion" = "15" ]
                     then
                      mn[15]=1

               elif [ "$opcion" = "20" ]
                     then
                      mn[20]=1

               elif [ "$opcion" = "25" ]
                     then
                      mn[25]=1


               elif [ "$opcion" = "30" ]
                     then
                      mn[30]=1


               elif [ "$opcion" = "35" ]
                     then
                      mn[35]=1


               elif [ "$opcion" = "40" ]
                     then
                      mn[40]=1

               elif [ "$opcion" = "45" ]
                     then
                      mn[45]=1

               elif [ "$opcion" = "50" ]
                     then
                      mn[50]=1

               elif [ "$opcion" = "55" ]
                     then
                      mn[55]=1

               fi
        done
#echo "0:"${mn[0]} "5:"${mn[5]} "10:"${mn[10]} "15:"${mn[15]} "20:"${mn[20]} "25:"${mn[25]} "30:"${mn[30]}


comercial=$(dialog --stdout --title "Seleccione el Comercial" --fselect $HOME/ 0 14 48)

echo $comercial

#########################

	i=0
		 while [  $i -le 23 ]; do     

	j=0
		 while [  $j -le 55 ]; do				     

#		hora=${hr[$i]}
			if [[ ${hr[$i]} -eq "1" ]]; then
#		minuto=${mn[$j]}
				if [[  ${mn[$j]} -eq "1" ]]; then

					vacio=1
					if [ -s ~/.guarangoradio-shell/data/comerciales/$i/$j.com ]; then
					vacio=0
					fi
				
					if [ $vacio = 1 ]; then
					echo "$comercial""|"$diasemite"|"$pautaini"|"$pautafin > ~/.guarangoradio-shell/data/comerciales/$i/$j.com
					echo primera linea
					else
					echo "$comercial""|"$diasemite"|"$pautaini"|"$pautafin >> ~/.guarangoradio-shell/data/comerciales/$i/$j.com
					echo segunda linea
					fi
				#sed '/^$/d' ~/.guarangoradio-shell/data/comerciales/$i/$j.com > ~/.guarangoradio-shell/data/comerciales/$i/$j.com
				echo $comercial
				fi
			fi
			j=$(($j+5))				
		done
	
		     i=$(($i+1)) 
		 done


		
             
echo listo es $listo
             listo=$(($listo+1)) 

dialog --stdout --title "Termino de programar los comerciales?" --backtitle "Cerrar Programación Comerciales" --yesno "Termino de programar los comerciales?" 7 60
#opcion=`echo $opcion|sed 's/\"//g'` 

if [ $? -eq 0 ]
then
~/.guarangoradio-shell/bin/guarango-gui.sh
exit
fi





         done
~/.guarangoradio-shell/bin/guarango-gui.sh

