#!/bin/bash

SF="/var/www/html/_station"

if ! grep 666 ${SF} > /dev/null
then
 if ! pidof mpg123 > /dev/null
  then
   runuser -l www-data -c '/usr/local/bin/runRadio.sh'
 fi
fi

