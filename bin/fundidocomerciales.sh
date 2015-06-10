mix=`zenity --list  --title="Gradio" --width "25" --height "300" --text="Tiempo de Fundido" --column="Segundos" "1" "2" "3" "4" "5" "6"`

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.guarangoradio/data/tmp/fundidocomerciales
fi
