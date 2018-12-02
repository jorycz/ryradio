#!/bin/bash

printf "\n\nStarting radio and sending mail (if set) ...\n\n"

sleep 10

amixer set PCM "90%"
# ANALOG
amixer cset numid=3 1
# HDMI
#amixer cset numid=3 2

# MAIL:
IP=$(hostname -I)
# Delete hash and replace someEmail@somewhere.com with your email address:
#echo "RyRadio RaspberryPI URL (local IP) : http://$IP/ " | mail -s "RyRadio Started." someEmail@somewhere.com

echo
echo "-> pi password is raspberry"
echo "-> IP is $IP"
echo

runuser -l www-data -c '/usr/local/bin/runRadio.sh'

