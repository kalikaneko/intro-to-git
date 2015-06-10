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
 
 opcion=$(dialog --stdout --checklist  "Guarango Radio -v:alfalfa" 50 40 60 1 "Ejecutar Guarango Radio" off 2 "Detener Guarango Radio" off 3 "Programar Comerciales" off 4 "Borrar Comerciales" off 5 "Programar Parrilla de Programación" off 6 "Abrir Panel de Efectos" off 7 "Reporte de audios emitidos" off 8 "Reporte de pautaje de comerciales" off 9 "Reporte de parrilla programada" off)

opcion=`echo $opcion|sed 's/\"//g'`

        for opcion in $opcion
        do
               if [ "$opcion" = "1" ];
                     then 			
		      ~/.guarangoradio-shell/bin/guarango.sh 
               elif [ "$opcion" = "2" ]
                     then

		dialog --title "Cerrar GR" --backtitle "Cerrar GuarangoRadio" --yesno "Esta seguro que quiere cerrar Guarangoradio?" 7 60

			
		if [ $? = 0 ]; then
                      kill -9 `cat ~/.guarangoradio-shell/data/pid`
		      killall -9 mpg321
		      ~/.guarangoradio-shell/bin/guarango-gui.sh
		fi

	      elif [ "$opcion" = "3" ]
                     then
                      ~/.guarangoradio-shell/bin/comercial.sh

                   
               elif [ "$opcion" = "4" ]
                     then
                      ~/.guarangoradio-shell/bin/comercialborrar.sh


              elif [ "$opcion" = "5" ]
                     then
                     ~/.guarangoradio-shell/bin/parrilla.sh
                     
              elif [ "$opcion" = "6" ]
                     then
		     # ~/.guarangoradio-shell/bin/guarango-gui.sh                      
		      ~/.guarangoradio-shell/bin/panel.sh 
		                

	      elif [ "$opcion" = "7" ]
                     then
                     ~/.guarangoradio-shell/bin/reporte.sh               

	      elif [ "$opcion" = "8" ]
                     then
                     ~/.guarangoradio-shell/bin/reportepautaje.sh 

	      elif [ "$opcion" = "9" ]
                     then
                     ~/.guarangoradio-shell/bin/reporteparrilla.sh 

               fi

        done



