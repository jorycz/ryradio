#!/bin/bash

SF="/var/www/html/rr/config/_station"
D="/tmp/radioReset.log"

if ! grep 666 ${SF} > /dev/null
then
 if ! pidof mpg123 > /dev/null
  then
   DA=$(date)
   echo "Trying to run Radio again on [ $DA ]" >> $D
   /var/www/html/rr/scripts/runRadio.sh &> /dev/null
 fi
fi

