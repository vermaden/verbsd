#! /bin/sh

# USE IN crontab(5) EVERY 5 MINUTES

# date +%Y.%m.%d
# 2024.11.02

# EXIT IF LOCK EXISTS
[ -f ${MIN_TIME_LOCK} ] && exit 0

# SETTINGS
MIN_TIME_FILE="/var/tmp/.time-limit-min-$( date +%Y.%m.%d )"
MIN_TIME_LOCK="/var/tmp/.time-limit-lck-$( date +%Y.%m.%d )"
MINUTES=$( wc -l ${MIN_TIME_FILE} )
MINUTES=$( echo ${MINUTES} )
LIMIT=120
MAX_COUNT=0
MAX_LIMIT=5

if [ ${MINUTES} -gt ${LIMIT} ]
then
  :> ${MIN_TIME_LOCK}
  sleep 60
  if which zenity 1> /dev/null 2> /dev/null
  then
    zenity --title 'Time Limit' --info --text 'Computer will poweroff(8) in 5 minutes.'
  fi
  MAX_COUNT=$(( ${MAX_COUNT} + 1 ))
  [ ${MAX_COUNT} -gt ${MAX_LIMIT} ] && sudo poweroff
fi

