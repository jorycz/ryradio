#!/bin/bash

HOUR="$(date +%H)"

SET_VOL=$(cat /var/www/html/rr/config/_volume)
DEVICE=$(cat /var/www/html/rr/config/_device)
LOWER="10"

#echo "Current device [ $DEVICE ] and DAY volume [ $SET_VOL ]."

if [ ${HOUR} -ge 8 ] && [ ${HOUR} -le 21 ]
then
  amixer set "$DEVICE" "${SET_VOL}%"
else
  NIGHT_VOLUME="$((SET_VOL-LOWER))"
  amixer set "$DEVICE" "${NIGHT_VOLUME}%"
fi

