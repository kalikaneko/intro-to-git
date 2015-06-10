mix=`zenity --list  --title="Gradio" --width "25" --height "300" --text="Tiempo de Disparo" --column="Segundos" "2" "4" "6" "8" "10" "12" "14" "16" "18" "20"`  

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.guarangoradio/data/tmp/disparo
fi
