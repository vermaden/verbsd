#! /bin/sh

__usage() {
  echo "usage: ${0##*/} OPTION DIR"
  echo "OPTION(s):  -f  by filename"
  echo "            -d  by dir"
  exit 1
  }

[ ${#} -ne 2 ] && __usage

case ${1} in
  (-f|-d)
    :
    ;;
  (*)
    __usage
    ;;
esac

find ${2} -type $( echo ${1} \
  | tr -d '-' ) \
  | while read I
    do
      echo "${I##*/}" | tr -c -d '0' 1> /dev/null 2> /dev/null || echo "${I}"
    done
