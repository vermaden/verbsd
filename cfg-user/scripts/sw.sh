#! /bin/sh
set -e

__usage() {
  NAME=${0##*/}
cat << EOF
usage:
  ${NAME} [-r | --resume]

options:
  -r | --resume - use saved start time from ~/.sw file

EOF
  exit 0
}

__finish() {
  # RESTORE CURSOR
  echo
  tput cnorm
  exit 0
}

trap __finish EXIT SIGINT

case ${1} in
  (-h|--h|help|-help|--help) __usage ;;
esac

# USE GNU date(1) IF POSSIBLE AS IT HAS NANOSECONDS SUPPORT
if hash gdate 2> /dev/null
then
  GNU_DATE=gdate
fi

__datef() {
  if [ -z "${GNU_DATE}" ]
  then
    date "${@}"
  else
    ${GNU_DATE} "${@}"
  fi
}

# DISPLAY NANOSECONDS ONLY IF SUPPORTED
if __datef +%N | grep -q N 2> /dev/null
then
  echo "INFO: install 'sysutils/coreutils' for nanoseconds support"
  DATE_FORMAT="+%H:%M:%S"
else
  DATE_FORMAT="+%H:%M:%S.%N"
  NANOS_SUPPORTED=true
fi

# HIDE CURSOR
tput civis

# IF '-r/--resume' IS PASSED - USE SAVED START TIME FROM ~/.sw FILE
if [ "${1}" = "-r" -o "${1}" = "--resume" ]
then
  if [ ! -f ~/.sw ]
  then
    __datef +%s > ~/.sw
  fi
  START_TIME=$( cat ~/.sw )
else
  START_TIME=$( __datef +%s )
  echo -n ${START_TIME} > ~/.sw
fi

# GNU date(1) ACCEPTS INPUT DATE DIFFERENTLY THAN BSD
if [ -z "${GNU_DATE}" ]
then
  DATE_INPUT="-v-${START_TIME}S"
else
  DATE_INPUT="--date now-${START_TIME}sec"
fi

# START STOPWATCH
while true
do
  STOPWATCH=$( TZ=UTC __datef ${DATE_INPUT} ${DATE_FORMAT} | ( [ "${NANOS_SUPPORTED}" ] && sed 's/.\{7\}$//' || cat ) )
  printf "\r%s" ${STOPWATCH}
  sleep 0.03
done
