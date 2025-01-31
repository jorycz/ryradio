#!/bin/bash

printf "\n\nStarting radio and sending mail (if set) ...\n\n"

sleep 10

# Before Pi OS update 28 May 2020 name was PCM, but then changed to Headphone
# https://github.com/mopidy/mopidy-alsamixer/issues/24
# So detect it
R="/var/www/html/rr/config/"

if [ -f ${R}/sleepAfterBoot ]
then
  sleep $(cat ${R}/sleepAfterBoot)
fi

amixer | grep "Simple mixer control" | sed "s;.* '\(.*\)'.*;\1;" > ${R}_device
DEV=$(cat ${R}_device)
amixer set $DEV "95%"
# Remove new line at the end
truncate -s -1 ${R}_device

# ANALOG
amixer cset numid=3 1
# HDMI
#amixer cset numid=3 2

# MAIL:
IP=$(hostname -I | awk '{print $1}')
# Delete hash and replace someEmail@somewhere.com with your email address:
RCPT="/var/www/html/rr/config/recipients"
if grep '@' ${RCPT} > /dev/null
 then
 MAILS=$(head -n 1 $RCPT)
 echo "RyRadio RaspberryPI URL (local IP) (device $DEV) on http://$IP/rr/ started." | mail -s "RyRadio Started." ${MAILS}
fi

echo
echo "-> pi password is raspberry"
echo "-> IP is $IP"
echo

D="/tmp/radioStartAfterBoot.log"
DA=$(date)
echo "Radio started after boot on [ $DA ] with DEV [ $DEV ] IP [ $IP ] with mails [ ${MAILS} ]." >> $D

/var/www/html/rr/scripts/runRadio.sh &

