#!/bin/bash
opcion=`/usr/bin/zenity --title="Programar Cadena" --width=400 --height=300 \
                         --text="Seleccione página web o URL de streaming" \
                         --list --column="Cadena" --column="Seleccione" \
                         --radiolist TRUE "Pagina_Web" FALSE "URL_streaming" `

if [ $? -eq 0 ]; then

usuario=`whoami`

archivo=`zenity --filename=/home/$usuario/Guarango\ Radio/ --file-selection --title="Seleccione el audio de entrada a la cadena"` 
if [ $? -eq 0 ]
then
        case $? in
                 0)
                        echo "\"$archivo\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
else
exit
fi

if [ $opcion = "Pagina_Web" ]; then
		url=`zenity --entry --text="Introduzca la dirección del sitio WEB ej: http://www.radiopublica.ec/" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		horastr=`zenity --entry --text="Introduzca la hora de inicio ej: 10:30" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		duracion=`zenity --entry --text="Ingrese la duración en segundos" --title="Duración"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		nombrebase=`echo "$archivo" |awk -F/ '{print $NF}'`
		archivo= `echo $archivo` 

		cola=`date +%s`
		echo "#!/bin/bash" > ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo "$nombrebase" > ~/.guarangoradio/data/tmp/currentsong.txt" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo "$nombrebase" > ~/CurrentSong.txt" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo '<font size='1' color='red'><b>$nombrebase</b></font>' > ~/.guarangoradio/data/tmp/currentsongweb" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "archduracion=\`avconv -i \"$archivo\"  2>&1 | egrep \"Duration\" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print \$1}'\`" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo \$archduracion > ~/.guarangoradio/data/tmp/duracion" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/pausa.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/countdown.sh &" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "mplayer \"$archivo\"" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "killall -9 panico.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "killall -9 countdown.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "killall -9 firefox" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo $url > ~/.guarangoradio/data/tmp/currentsong.txt" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "export DISPLAY=:0.0" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "firefox $url &" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo 00:00:$duracion > ~/.guarangoradio/data/tmp/duracion" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/countdown.sh &" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "sleep $duracion" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "killall -9 firefox" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/despausa.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/siguiente.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		chmod 755 ~/.guarangoradio/data/streaming/str$cola.sh
		at -f ~/.guarangoradio/data/streaming/str$cola.sh $horastr > ~/.guarangoradio/data/tmp/streaming 2>&1
		zenity --info --text "ha programado la página $url con $duracion segundos de duración a las $horastr"
else
		url=`zenity --entry --text="Introduzca la dirección de streaming ej: http://91.121.159.50:8000/rvtnapo" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		horastr=`zenity --entry --text="Introduzca la hora de inicio ej: 10:30" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		duracion=`zenity --entry --text="Ingrese la duración en segundos" --title="Duración"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		cola=`date +%s`
		echo "#!/bin/bash" > ~/.guarangoradio/data/streaming/str$cola.sh
		echo "killall -9 panico.sh" > ~/.guarangoradio/data/streaming/str$cola.sh
		echo 'mplayer "$archivo"' >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/pausa.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "echo $url > ~/.guarangoradio/data/tmp/currentsong.txt" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "mplayer -volume 100 -endpos $duracion $url"  >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/despausa.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		echo "~/.guarangoradio/bin/siguiente.sh" >> ~/.guarangoradio/data/streaming/str$cola.sh
		chmod 755 ~/.guarangoradio/data/streaming/str$cola.sh

		at -f ~/.guarangoradio/data/streaming/str$cola.sh $horastr > ~/.guarangoradio/data/tmp/streaming 2>&1
		zenity --info --text "ha programado la página $url con $duracion segundos de duración a las $horastr"
fi
fi
