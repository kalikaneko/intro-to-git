#!/bin/bash
lazo=0
ancho=`sed -n 1p ~/.guarangoradio/data/tmp/logo.info`
alto=`sed -n 2p ~/.guarangoradio/data/tmp/logo.info`
while [ $lazo -le 5 ]; do
echo "RGBA32 $ancho $alto 10 10 0 0"  > ~/.guarangoradio/data/tmp/logo.fifo && cat ~/.guarangoradio/data/tmp/logo.rgba > ~/.guarangoradio/data/tmp/logo.fifo
sleep 1
lazo=$(($lazo + 1))
done
exit 0
