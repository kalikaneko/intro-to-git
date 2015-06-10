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

#Interfaz gráfica para guarango radio

opcion=$(dialog --stdout --checklist  "Guarango Radio Efectos" 50 40 60 1 "Efecto 1" off 2 "Efecto 2" off 3 "Efecto 3" off 4 "Efecto 4" off 5 "Efecto 5" off 6 "Efecto 6" off 7 "Efecto 7" off 8 "Efecto 8" off 9 "Efecto 9" off 10 "Efecto 10" off 11 "Reproducir Hora" off 12 "Programar Efectos" off)
opcion=`echo $opcion|sed 's/\"//g'` 
echo $opcion

        for opcion in $opcion
        do
               if [ "$opcion" = "1" ];
                     then 
                      ~/.guarangoradio-shell/data/panel/efecto1.sh &			
               elif [ "$opcion" = "2" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto2.sh &                   
               elif [ "$opcion" = "3" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto3.sh &
               elif [ "$opcion" = "4" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto4.sh &
               elif [ "$opcion" = "5" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto5.sh &
               elif [ "$opcion" = "6" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto6.sh &
               elif [ "$opcion" = "7" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto7.sh &
               elif [ "$opcion" = "8" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto8.sh &
               elif [ "$opcion" = "9" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto9.sh &
               elif [ "$opcion" = "10" ]
                     then
                      ~/.guarangoradio-shell/data/panel/efecto10.sh &
               elif [ "$opcion" = "11" ]
                     then
                      ~/.guarangoradio-shell/data/panel/hora.sh &
               elif [ "$opcion" = "12" ]
                     then
                      ~/.guarangoradio-shell/bin/panelprogramar.sh 
               fi
        done

~/.guarangoradio-shell/bin/panel.sh 
exit 

