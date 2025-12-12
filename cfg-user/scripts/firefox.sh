#! /bin/sh

if [ ${#} -eq 0 ]
then
  echo "usage: ${0##*/} FILE"
  echo
  exit 1
fi

firefox --new-tab "${@}"
