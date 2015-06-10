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
 
opcion=`/usr/bin/zenity --title="Guarango Radio" --width=280 --height=350 \
                         --text="Programar El Panel de Efectos " \
                         --list --column="Selección" --column="Programar" \
                         --checklist FALSE "Programar Efecto 1" FALSE "Programar Efecto 2" FALSE "Programar Efecto 3" FALSE "Programar Efecto 4" FALSE "Programar Efecto 5" FALSE "Programar Efecto 6" FALSE "Programar Efecto 7" FALSE "Programar Efecto 8" FALSE "Programar Efecto 9" FALSE "Programar Efecto 10" FALSE "Volver al Panel de Efectos" `
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Programar Efecto 1" ];
                     then 
      efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto1.sh

               elif [ "$opcion" = "Programar Efecto 2" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto2.sh
                   
               elif [ "$opcion" = "Programar Efecto 3" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto3.sh

               elif [ "$opcion" = "Programar Efecto 4" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto4.sh

               elif [ "$opcion" = "Programar Efecto 5" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto5.sh

               elif [ "$opcion" = "Programar Efecto 6" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto6.sh

               elif [ "$opcion" = "Programar Efecto 7" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto7.sh

               elif [ "$opcion" = "Programar Efecto 8" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto8.sh

               elif [ "$opcion" = "Programar Efecto 9" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto9sh

               elif [ "$opcion" = "Programar Efecto 10" ]
                     then

 efecto=`zenity --filename="~/Música/" --file-selection --title="Seleccione el archivo de audio a ser programado como efecto"` 

        case $? in
                 0)
                        echo "\"$efecto\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
                 echo "gmplayer \"$efecto\"" > ~/.guarangoradio/data/panel/efecto10.sh



               elif [ "$opcion" = "Volver al Panel de Efectos" ]
                     then
                      ~/.guarangoradio/data/panel.sh

               fi
        done
        IFS=""
       
fi
