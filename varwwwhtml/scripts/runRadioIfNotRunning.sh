#!/bin/bash

SF="/var/www/html/_station"
D="/tmp/radioReset.log"

if ! grep 666 ${SF} > /dev/null
then
 if ! pidof mpg123 > /dev/null
  then
   DA=$(date)
   echo "Trying to run Radio again on [ $DA ]" >> $D
   /sbin/runuser -l www-data -c '/usr/local/bin/runRadio.sh' &> /dev/null
 fi
fi

