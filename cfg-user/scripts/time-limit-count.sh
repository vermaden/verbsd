#! /bin/sh

MIN_TIME_FILE="/var/tmp/.time-limit-min-$( date +%Y.%m.%d )"

echo 1 >> ${MIN_TIME_FILE}

