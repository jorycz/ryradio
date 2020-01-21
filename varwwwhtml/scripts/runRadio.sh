#!/bin/bash

killall mpg123 &
sleep 1
/sbin/runuser -l www-data -c 'php -f /var/www/html/index.php' 1>/dev/null

