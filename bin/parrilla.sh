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

#Programar la parrilla de música por horas

opcion=$(dialog --stdout --checklist  "Seleccione los días de programación" 50 40 40 1 lunes on 2 martes on 3 miércoles on 4 jueves on 5 viernes on 6 sábado off 7 domingo off)

opcion=`echo $opcion|sed 's/\"//g'`

        for opcion in $opcion
        do
               if [ "$opcion" = "1" ];
                     then 
                      dia[1]=1
               elif [ "$opcion" = "2" ]
                     then
                      dia[2]=1
              elif [ "$opcion" = "3" ]
                     then
                      dia[3]=1
                     
             elif [ "$opcion" = "4" ]
                     then
                      dia[4]=1

	     elif [ "$opcion" = "5" ]
                     then
                      dia[5]=1

	     elif [ "$opcion" = "6" ]
                     then
                      dia[6]=1
 
	     elif [ "$opcion" = "7" ]
                     then
                      dia[7]=1
 
 
               fi
        done

opcion=$(dialog --stdout --checklist  "Sleccione la Horas a Programar" 50 40 60 0 00-01 off 1 01-02 off 2 02-03 off 3 03-04 off 4 04-05 off 5 05-06 off 6 06-08 off 7 07-08 off 8 08-09 off 9 09-10 off 10 10-11 off 11 11-12 off 12 12-13 off 13 13-14 off 14 14-15 off 15 15-16 off 16 16-17 off 17 17-18 off 18 18-19 off 19 19-20 off 20 20-21 off 21 21-22 off 22 22-23 off 23 23-00 off)

opcion=`echo $opcion|sed 's/\"//g'`


        for opcion in $opcion
        do
               if [ "$opcion" = "0" ];
                     then 
                      rango[0]=1
               elif [ "$opcion" = "1" ]
                     then
                      rango[1]=1
              
               elif [ "$opcion" = "2" ]
                     then
                      rango[2]=1
 
               elif [ "$opcion" = "3" ]
                     then
                      rango[3]=1

               elif [ "$opcion" = "4" ]
                     then
                      rango[4]=1

               elif [ "$opcion" = "5" ]
                     then
                      rango[5]=1

               elif [ "$opcion" = "6" ]
                     then
                      rango[6]=1

               elif [ "$opcion" = "7" ]
                     then
                      rango[7]=1

               elif [ "$opcion" = "8" ]
                     then
                      rango[8]=1

               elif [ "$opcion" = "9" ]
                     then
                      rango[9]=1

               elif [ "$opcion" = "10" ]
                     then
                      rango[10]=1

               elif [ "$opcion" = "11" ]
                     then
                      rango[11]=1

               elif [ "$opcion" = "12" ]
                     then
                      rango[12]=1

               elif [ "$opcion" = "13" ]
                     then
                      rango[13]=1
               
               elif [ "$opcion" = "14" ]
                     then
                      rango[14]=1

               elif [ "$opcion" = "15" ]
                     then
                      rango[15]=1

               elif [ "$opcion" = "16" ]
                     then
                      rango[16]=1

               elif [ "$opcion" = "17" ]
                     then
                      rango[17]=1

               elif [ "$opcion" = "18" ]
                     then
                      rango[18]=1

               elif [ "$opcion" = "19" ]
                     then
                      rango[19]=1

               elif [ "$opcion" = "20" ]
                     then
                      rango[20]=1

               elif [ "$opcion" = "21" ]
                     then
                      rango[21]=1

               elif [ "$opcion" = "22" ]
                     then
                      rango[22]=1

               elif [ "$opcion" = "23" ]
                     then
                      rango[23]=1

               fi
        done



listo=0
         

while [  $listo -ne 1000 ]; do

dir=$(dialog --stdout --title "Seleccione una Carpeta de audios para reproducir aleatoriamente" --dselect $HOME/ 0 14 48)

#Insertar hora
dialog --stdout --title "Parrilla GR" --backtitle "Insertar Hora" --yesno "Desea insertar la hora en la lista?" 7 60
#opcion=`echo $opcion|sed 's/\"//g'` 

if [ $? -eq 0 ]
then
hora="Si"
fi

			
			#Fin insertar hora
					
######


i=1
			 while [  $i -le 7 ]; do
			     #echo i $i

		j=0
				 while [  $j -le 23 ]; do
				     #echo j $j

					if [[ ${dia[$i]} -eq "1" ]]; then
						if [[  ${rango[$j]} -eq "1" ]]; then
						rangoc=$j-$(($j+1))
						echo dia $i rango $rangoc horadialog $hora

							if [ $listo = 0 ]; then
								echo $dir"/*" > ~/.guarangoradio-shell/data/parrilla/$i/$rangoc.mus		
							   else
								echo $dir"/*" >> ~/.guarangoradio-shell/data/parrilla/$i/$rangoc.mus
							fi
							
							if [ $hora = "Si" ]; then
								echo Hora >> ~/.guarangoradio-shell/data/parrilla/$i/$rangoc.mus
							fi

							cat ~/.guarangoradio-shell/data/parrilla/$i/$rangoc.mus
######

						fi
					fi
					j=$(($j+1))				
				done
		
			     i=$(($i+1)) 
			 done
			 hora=No


################
	
		




		cat ~/.guarangoradio-shell/data/parrilla/$dia/$rango.mus

             echo listo es $listo
             listo=$(($listo+1)) 


dialog --stdout --title "Parrilla GR" --backtitle "Final?" --yesno "Termino la creación de la lista?" 7 60
#opcion=`echo $opcion|sed 's/\"//g'` 

if [ $? -eq 0 ]
then
listo=1000
fi


         done

~/.guarangoradio-shell/bin/guarango-gui.sh




