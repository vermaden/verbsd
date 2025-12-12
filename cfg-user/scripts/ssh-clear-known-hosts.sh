#! /bin/sh

if [ ${#} -ne 1 ]
then
  echo "usage: ${0##*/} LINE"
  echo
  echo "example: ${0##*/} 28"
  echo "         ^"
  echo "         This line above will clear 28 line of the ~/.ssh/known_hosts file."
  exit 1
fi

ed ~/.ssh/known_hosts ${1}d wq
