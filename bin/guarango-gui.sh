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
 
 
 
opcion=`/usr/bin/zenity --title="Guarango Radio -v:alfalfa" --width=400 --height=350 \
                         --text="Seleccione la acción" \
                         --list --column="Seleccionar" --column="Acción" \
			 --checklist FALSE "Ejecutar Guarango Radio" FALSE "Detener Guarango Radio" FALSE "Programar Comerciales" FALSE "Borrar Comerciales" FALSE "Programar Parrilla de Programación" FALSE "Abrir Panel de Efectos" FALSE "Reporte de audios emitidos" FALSE "Reporte de pautaje de comerciales" FALSE "Reporte de parrilla programada"`
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Ejecutar Guarango Radio" ];
                     then 			
		      ~/.guarangoradio/bin/guarango.sh 
               elif [ "$opcion" = "Detener Guarango Radio" ]
                     then
			zenity --question --text "Esta seguro que quiere cerrar Guarangoradio"; echo $?
		if [ $? = 0 ]; then
                      kill -9 `cat ~/.guarangoradio/data/pid`
		      killall -9 smplayer
		      ~/.guarangoradio/bin/guarango-gui.sh
		fi

	      elif [ "$opcion" = "Programar Comerciales" ]
                     then
                      ~/.guarangoradio/bin/comercial.sh

                   
               elif [ "$opcion" = "Borrar Comerciales" ]
                     then
                      ~/.guarangoradio/bin/comercialborrar.sh


              elif [ "$opcion" = "Programar Parrilla de Programación" ]
                     then
                     ~/.guarangoradio/bin/parrilla.sh
                     
              elif [ "$opcion" = "Abrir Panel de Efectos" ]
                     then
		      ~/.guarangoradio/bin/guarango-gui.sh &                     
		      ~/.guarangoradio/bin/panel.sh & 
		                

	      elif [ "$opcion" = "Reporte de audios emitidos" ]
                     then
                     ~/.guarangoradio/bin/reporte.sh               

	      elif [ "$opcion" = "Reporte de pautaje de comerciales" ]
                     then
                     ~/.guarangoradio/bin/reportepautaje.sh 

	      elif [ "$opcion" = "Reporte de parrilla programada" ]
                     then
                     ~/.guarangoradio/bin/reporteparrilla.sh 

               fi

        done
        IFS=""    
fi

