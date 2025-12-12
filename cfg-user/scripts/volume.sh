#! /bin/sh

UNIT=$( awk -F ':' '/ default$/ {print $1}' /dev/sndstat | tr -cd '0-9' )

DEV=/dev/mixer${UNIT}

mixer -f ${DEV} pcm.volume=1.00 1> /dev/null 2> /dev/null

case ${1} in
  (up|+)
    mixer -f ${DEV} vol.volume=+0.05 1> /dev/null 2> /dev/null
    ;;
  (down|-)
    mixer -f ${DEV} vol.volume=-0.05 1> /dev/null 2> /dev/null
    ;;
esac




