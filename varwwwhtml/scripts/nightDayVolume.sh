#!/bin/bash

HOUR="$(date +%H)"

SET_VOL=$(cat /var/www/html/rr/config/_volume)
DEVICE=$(cat /var/www/html/rr/config/_device)
LOWER="10"

D="/tmp/radioVolume.log"
DA=$(date)

#echo "Current device [ $DEVICE ] and DAY volume [ $SET_VOL ]."

if [ ${HOUR} -ge 8 ] && [ ${HOUR} -le 21 ]
then
  amixer set "$DEVICE" "${SET_VOL}%"
  echo "Radio DAY volume set on [ $DA ] to [ ${SET_VOL} ]." >> $D
else
  NIGHT_VOLUME="$((SET_VOL-LOWER))"
  amixer set "$DEVICE" "${NIGHT_VOLUME}%"
  echo "Radio NIGHT volume set on [ $DA ] to [ ${NIGHT_VOLUME} ]." >> $D
fi
