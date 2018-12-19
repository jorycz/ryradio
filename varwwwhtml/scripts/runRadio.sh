#!/bin/bash

killall mpg123 &
sleep 1
php -f /var/www/html/index.php 1>/dev/null


