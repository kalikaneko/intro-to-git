mix=`zenity --list --title="Fundido" --width "25" --height "200" --text="Tiempo de fundido" --column="Segundos" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"`

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.guarangoradio/data/mix.txt
fi
