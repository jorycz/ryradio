#!/bin/bash

HOUR="$(date +%H)"

SET_VOL=$(cat /var/www/html/config/_volume)
DEVICE=$(cat /var/www/html/config/_device)
LOWER="10"

echo "Current device [ $DEVICE ] and DAY volume [ $SET_VOL ]."

amixer

if [ ${HOUR} -ge 8 ] && [ ${HOUR} -le 22 ]
then
  amixer set "$DEVICE" "${SET_VOL}"
else
  NIGHT_VOLUME="$((SET_VOL-LOWER))"
  amixer set "$DEVICE" "${NIGHT_VOLUME}"
fi

amixer

