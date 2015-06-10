#!/bin/bash

#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 18-Enero-2011		    #
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

#Borrar comerciales
   #!/bin/sh

        FILE=`zenity --file-selection --title="Seleccione el archivo del comercial a borrar"`

        case $? in
                 0)
                        echo "\"$FILE\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac


comborrar=$FILE
#echo este es el comercial a borrar $comborrar

#echo filtro es `grep -li "$comborrar" ~/.guarangoradio-shell/data/comerciales/*/*.com`

for i in `grep -li "$comborrar" ~/.guarangoradio-shell/data/comerciales/*/*.com`
do
linea=`grep -in "$comborrar" $i | sed -n 's/^\([0-9]*\)[:].*/\1/p'`
d=d
mised="sed $linea$d $i"
$mised > $i
done

~/.guarangoradio-shell/bin/guarango-gui.sh

