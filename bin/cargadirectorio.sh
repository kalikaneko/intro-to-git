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
usuario=`whoami`

       dir=`zenity --filename=/home/$usuario/Guarango\ Radio/musica/ --file-selection --directory --title="Seleccione una Carpeta de audios para reproducir aleatoriamente"` 

if [ $? -eq 0 ]
then
        case $? in
                 0)
                        echo "\"$dir\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
		
        esac
else
exit
fi
dirbase=`basename "$dir"`
echo "$dir/*" >> ~/.guarangoradio/data/tmp/parrillag3
echo "$dirbase/*" >> ~/.guarangoradio/data/tmp/baseparrillag3
