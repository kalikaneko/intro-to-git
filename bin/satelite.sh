mix=`zenity --list --title="Menu" --text="Tiempo de Mezcla" --column="Segundos" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"`

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.guarangoradio/data/mix.txt
fi
