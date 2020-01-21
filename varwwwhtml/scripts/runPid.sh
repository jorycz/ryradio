#!/bin/bash

if ! pidof mpg123 > /dev/null
 then
  mpg123 --timeout 10 -@ "${1}" &> /dev/null
fi

