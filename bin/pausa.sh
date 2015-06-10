#!/bin/bash
echo pause > ~/.guarangoradio/data/tmp/slave.txt
kill -SIGSTOP `cat ~/.guarangoradio/data/pid`
kill -SIGSTOP `pidof sleep`

