#! /usr/bin/env bash

# horizontal calendar for conky by ans

# modifications by vermaden to make it work on FreeBSD
# /bin/bash --> /usr/bin/env bash (provided by BASH package)
# date -------> gdate             (provided by COREUTILS package)

MON="Mo"; THU="Tu"; WED="We"; THR="Th"; FRI="Fr"; SAT="Sa"; SUN="Su";

TODAY=`gdate +%d`
LASTDAY=`gdate -d "-$TODAY days +1 month" +%d`
FIRSTDAY=`gdate -d "-$[${TODAY/#0/}-1] days" +%u`

TOPLINE=""
OVER="\${color #888888}"
REST="\${color #888888}"
NEXTMONTH="\${color #888888}"
TODAYC="\${color #22bbdd}${TODAY} "

I=1
if [ ${TODAY} -ne 1 ]
then
  while [ ${I} -lt ${TODAY} ]
  do
    if [ ${I} -lt 10 ]
    then
      OVER="${OVER}0${I} "
    else
      OVER="${OVER}${I} "
    fi
    I=$[ ${I} + 1 ]
  done
fi

I=$[ ${I} + 1 ]
if [ ${TODAY} -ne ${LASTDAY} ]
then
  while [ ${I} -ne ${LASTDAY} ]
  do
    if [ ${I} -lt 10 ]
    then
      REST="${REST}0${I} "
    else
      REST="${REST}${I} "
    fi
    I=$[ ${I} + 1 ]
  done
  REST="${REST}${LASTDAY} "
fi

I=${LASTDAY}
J=1
while [ ${I} -lt 31 ]
do
  NEXTMONTH="${NEXTMONTH}0${J} "
  I=$[ ${I} + 1 ]
  J=$[ ${J} + 1 ]
done

J=31
K=${FIRSTDAY}
while [ ${J} -gt 0 ]
do
  case "${K}" in
    (7) TOPLINE="${TOPLINE}\${color dd0000}${SUN}\${color} " ;;
    (1) TOPLINE="${TOPLINE}${MON} " ;;
    (2) TOPLINE="${TOPLINE}${THU} " ;;
    (3) TOPLINE="${TOPLINE}${WED} " ;;
    (4) TOPLINE="${TOPLINE}${THR} " ;;
    (5) TOPLINE="${TOPLINE}${FRI} " ;;
    (6) TOPLINE="${TOPLINE}\${color ff8c00}${SAT}\${color} " ;;
  esac
  J=$[ ${J} - 1 ]
  K=$[ ${K} + 1 ]
  if [ ${K} -eq 8 ]
  then
    K=1
  fi
done

# echo "\${color #dddddd}date(1)"
echo "${TOPLINE}"
echo "${OVER}${TODAYC}${REST}${NEXTMONTH}"
