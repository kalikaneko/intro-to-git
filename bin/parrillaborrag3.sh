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
nparrilla=`grep -c $ ~/.guarangoradio/data/tmp/parrillag3`
sed -i "$nparrilla""d" ~/.guarangoradio/data/tmp/parrillag3
nparrilla=`grep -c $ ~/.guarangoradio/data/tmp/baseparrillag3`
sed -i "$nparrilla""d" ~/.guarangoradio/data/tmp/baseparrillag3
