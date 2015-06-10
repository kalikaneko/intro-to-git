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

#Interfaz gráfica para guarango radio - programar panel de efectos

opcion=$(dialog --stdout --checklist  "GR Programar Efectos" 50 50 60 1 "Programar Efecto 1" off 2 "Programar Efecto 2" off 3 "Programar Efecto 3" off 4 "Programar Efecto 4" off 5 "Programar Efecto 5" off 6 "Progrmar Efecto 6" off 7 "Efecto 7" off 8 "Efecto 8" off 9 "Efecto 9" off 10 "Efecto 10" off 11 "Volver al Panel de Efectos" off)
opcion=`echo $opcion|sed 's/\"//g'`

        for opcion in $opcion
        do
               if [ "$opcion" = "1" ];
                     then 

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
               echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto1.sh 

               elif [ "$opcion" = "2" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
               echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto2.sh
                   
               elif [ "$opcion" = "3" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto3.sh

               elif [ "$opcion" = "4" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0  14 48)

                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto4.sh

               elif [ "$opcion" = "5" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto5.sh

               elif [ "$opcion" = "6" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto6.sh

               elif [ "$opcion" = "7" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto7.sh

               elif [ "$opcion" = "8" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto8.sh

               elif [ "$opcion" = "9" ]
                     then
efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto9sh

               elif [ "$opcion" = "10" ]
                     then

efecto=$(dialog --stdout --title "Seleccione el archivo de audio a ser programado como efecto" --fselect $HOME/ 0 14 48)
                 echo "mpg321 \"$efecto\"" > ~/.guarangoradio-shell/data/panel/efecto10.sh


               elif [ "$opcion" = "11" ]
                     then
                      ~/.guarangoradio-shell/bin/panel.sh

               fi
        done

