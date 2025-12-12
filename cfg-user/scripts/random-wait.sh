#! /bin/sh

RANDOM=$( head -c 256 /dev/urandom | env LC_ALL=C tr -c -d '1-9' )
MODULO=$(( ${RANDOM} % 24 ))
WAIT=$( echo ${MODULO} / 10 | bc -l )
WAIT=$( printf "%.1f" ${WAIT} )
echo ${WAIT}
