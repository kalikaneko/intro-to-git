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
 
opcion=`/usr/bin/zenity --title="Guarango Radio" --width=210 --height=350 \
                         --text="Panel de Efectos" \
                         --list --column="Selección" --column="Reproducir" \
                         --checklist FALSE "Efecto 1" FALSE "Efecto 2" FALSE "Efecto 3" FALSE "Efecto 4" FALSE "Efecto 5" FALSE "Efecto 6" FALSE "Efecto 7" FALSE "Efecto 8" FALSE "Efecto 9" FALSE "Efecto 10" FALSE "Reproducir Hora" FALSE "Programar Efectos" `
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Efecto 1" ];
                     then 
                      ~/.guarangoradio/data/panel/efecto1.sh &			
               elif [ "$opcion" = "Efecto 2" ]
                     then
                      ~/.guarangoradio/data/panel/efecto2.sh &                   
               elif [ "$opcion" = "Efecto 3" ]
                     then
                      ~/.guarangoradio/data/panel/efecto3.sh &
               elif [ "$opcion" = "Efecto 4" ]
                     then
                      ~/.guarangoradio/data/panel/efecto4.sh &
               elif [ "$opcion" = "Efecto 5" ]
                     then
                      ~/.guarangoradio/data/panel/efecto5.sh &
               elif [ "$opcion" = "Efecto 6" ]
                     then
                      ~/.guarangoradio/data/panel/efecto6.sh &
               elif [ "$opcion" = "Efecto 7" ]
                     then
                      ~/.guarangoradio/data/panel/efecto7.sh &
               elif [ "$opcion" = "Efecto 8" ]
                     then
                      ~/.guarangoradio/data/panel/efecto8.sh &
               elif [ "$opcion" = "Efecto 9" ]
                     then
                      ~/.guarangoradio/data/panel/efecto9.sh &
               elif [ "$opcion" = "Efecto 10" ]
                     then
                      ~/.guarangoradio/data/panel/efecto10.sh &
               elif [ "$opcion" = "Reproducir Hora" ]
                     then
                      ~/.guarangoradio/data/panel/hora.sh &
               elif [ "$opcion" = "Programar Efectos" ]
                     then
                      ~/.guarangoradio/bin/panelprogramar.sh &
               fi
        done
        IFS=""
~/.guarangoradio/bin/panel.sh &       
fi
