#!/bin/bash
usuario=`whoami`
logo=`zenity --filename=/home/$usuario/Guarango\ Radio/logo/ --file-selection --title="Seleccione el logo en formato PNG"` 

		if [ $? -eq 0 ]
		then
			case $? in
				 0)
				        echo "\"$logo\" seleccionado.";;
				 1)
				        echo "No ha seleccionado ningún archivo.";;
				-1)
				        echo "No ha seleccionado ningún archivo.";;
			esac
		fi
		#########################
if [[ $? = 0 ]]; then
extension="${logo##*.}"
valido=`echo $extension|grep -i PNG`
if [[ $valido != "" ]]; then
convert "$logo" ~/.guarangoradio/data/tmp/logo.rgba
ancho=`file "$logo"|awk -F "," '{print $2}'|awk '{print $1}'`
alto=`file "$logo"|awk -F "," '{print $2}'|awk '{print $3}'`
echo $ancho > ~/.guarangoradio/data/tmp/logo.info
echo $alto >> ~/.guarangoradio/data/tmp/logo.info
else
zenity --warning --text "El archivo seleccionado no es PNG"
fi
fi
exit 0
