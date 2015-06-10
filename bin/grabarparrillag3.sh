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


dia=1
while [[ $dia -le 7 ]]; do
d=`cat ~/.guarangoradio/data/tmp/d$dia`
if [[ $d = 1 ]]; then
	hora=0
	while [[ $hora -le 23 ]]; do
	h=`cat ~/.guarangoradio/data/tmp/$hora`
		if [[ $h = 1 ]]; then
		cp ~/.guarangoradio/data/tmp/parrillag3 ~/.guarangoradio/data/parrilla/$dia/$hora-$(($hora + 1)).mus
		fi
	hora=$(($hora + 1))
	done
fi
dia=$(($dia + 1))
done


echo 0 > ~/.guarangoradio/data/tmp/0
echo 0 > ~/.guarangoradio/data/tmp/1
echo 0 > ~/.guarangoradio/data/tmp/2
echo 0 > ~/.guarangoradio/data/tmp/3
echo 0 > ~/.guarangoradio/data/tmp/4
echo 0 > ~/.guarangoradio/data/tmp/5
echo 0 > ~/.guarangoradio/data/tmp/6
echo 0 > ~/.guarangoradio/data/tmp/7
echo 0 > ~/.guarangoradio/data/tmp/8
echo 0 > ~/.guarangoradio/data/tmp/9
echo 0 > ~/.guarangoradio/data/tmp/10
echo 0 > ~/.guarangoradio/data/tmp/11
echo 0 > ~/.guarangoradio/data/tmp/12
echo 0 > ~/.guarangoradio/data/tmp/13
echo 0 > ~/.guarangoradio/data/tmp/14
echo 0 > ~/.guarangoradio/data/tmp/15
echo 0 > ~/.guarangoradio/data/tmp/16
echo 0 > ~/.guarangoradio/data/tmp/17
echo 0 > ~/.guarangoradio/data/tmp/18
echo 0 > ~/.guarangoradio/data/tmp/19
echo 0 > ~/.guarangoradio/data/tmp/20
echo 0 > ~/.guarangoradio/data/tmp/21
echo 0 > ~/.guarangoradio/data/tmp/22
echo 0 > ~/.guarangoradio/data/tmp/23
echo 0 > ~/.guarangoradio/data/tmp/d1
echo 0 > ~/.guarangoradio/data/tmp/d2
echo 0 > ~/.guarangoradio/data/tmp/d3
echo 0 > ~/.guarangoradio/data/tmp/d4
echo 0 > ~/.guarangoradio/data/tmp/d5
echo 0 > ~/.guarangoradio/data/tmp/d6
echo 0 > ~/.guarangoradio/data/tmp/d7

cat /dev/null > ~/.guarangoradio/data/tmp/parrillag3
sed -i "1d" ~/.guarangoradio/data/tmp/parrillag3
cat /dev/null > ~/.guarangoradio/data/tmp/baseparrillag3
sed -i "1d" ~/.guarangoradio/data/tmp/baseparrillag3
killall -9 cargalista.sh
sleep 1
~/.guarangoradio/bin/cargalista.sh
