#!/bin/bash
b=`ps -e |grep playmancom.sh`
if [ "$b" = "" ]; then 
echo "0" > ~/.guarangoradio/data/tmp/stopcomercial
~/.guarangoradio/bin/playmancom.sh
else
echo "0" > ~/.guarangoradio/data/tmp/stopcomercial
fi
