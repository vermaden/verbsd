#! /bin/sh

__buffer() {
  # GET ALL OUTPUT INTO VARIABLE FOR FAST DISPLAY
  BUFFER="vmtop: running mode every '${DELAY}' seconds.
EXIT: press and hold [CTRL]+[C] keys.
$( 
  VM_LIST=$( ${DOAS} vm list -v )
  echo
  echo "${VM_LIST}" | grep -m 1 '^NAME' | head -1
  echo "${VM_LIST}" | sed 1d | sort -r -k 9
  echo
 )"

  echo "${BUFFER}"
  BACK=$( echo "${BUFFER}" | wc -l )
 
  # MOVE CURSOR BACK TO BEGINING INSTEAD clear(1) BUILTIN
  seq ${BACK} | xargs -I- tput cuu1
}

# SETTINGS
DELAY=1

# CHECK doas(1) AND/OR sudo(8) EXISTENCE
unalias doas
unalias sudo
if   which doas 1> /dev/null 2> /dev/null; then DOAS=doas
elif which sudo 1> /dev/null 2> /dev/null; then DOAS=sudo
else DOAS=''
fi

# CHECK IF INTERVAL IS NATURAL NUMBER
REGEX_NUMBER=$( echo ${DELAY} | grep -E -o "[0-9]+" )
if [ "${DELAY}" != "${REGEX_NUMBER}" ]
then
  echo "NOPE: the INTERVAL must be natural number"
  exit 1
fi
 
# UNHIDE CURSOR ON EXIT
trap 'tput cnorm' SIGINT SIGQUIT SIGHUP SIGTRAP SIGABRT SIGTERM
 
# HIDE CURSOR
tput civis
 
# CLEAR SCREEN ONE TIME
clear
 
# GET basename(1) NAME OF PROGRAM
NAME=${0##*/}
 
# RUN 'INTERVAL' LOOP
__buffer ${DELAY}
while sleep ${DELAY}
do
  __buffer ${DELAY}
done
exit 0

