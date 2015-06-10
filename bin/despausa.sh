#!/bin/bash
echo pause > ~/.guarangoradio/data/tmp/slave.txt
kill -SIGCONT `cat ~/.guarangoradio/data/pid`
kill -SIGCONT `pidof sleep`

