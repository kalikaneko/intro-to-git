#/bin/bash
wget -O ~/.guarangoradio/data/tmp/tiempo-clima http://www.accuweather.com/es/ec/tena/124695/daily-weather-forecast/124695?day=1 > /dev/null 2>&1
minimo=`grep "\"lo\">M&#237;n" ~/.guarangoradio/data/tmp/tiempo-clima|awk '{print $8}'|awk -F ">" '{print $2}'|awk -F "<" '{print $1}'`  
maximo=`grep "\"hi\">M&#225;x" ~/.guarangoradio/data/tmp/tiempo-clima|awk '{print $8}'|awk -F ">" '{print $2}'|awk -F "<" '{print $1}'` 
clima="Temperatura en Tena-Ecuador: Mínimo "$minimo"°C  Máximo "$maximo"°C"

wget -O ~/.guarangoradio/data/tmp/tiempo-clima http://www.accuweather.com/es/ec/quito/129846/weather-forecast/129846 > /dev/null 2>&1
sensacion=`grep RealFeel\&reg ~/.guarangoradio/data/tmp/tiempo-clima |awk '{print $3}'|awk -F \& '{print $1}'`
climaq="Sensación térmica en Quito-Ecuador: "$sensacion"°C"
echo  "$clima ------ $climaq"|twidge update 
#twidge update unicode "$clima ------- $climaq" &

