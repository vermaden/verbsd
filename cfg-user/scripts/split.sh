#! /bin/sh

[ ${#} -ne 2 ] && {
  echo "usage: ${0##*/} SIZE FILE"
  echo "  SIZE - part size (with G/M/K units)"
  echo "  FILE - name of file to be split"
  echo "example: ${0##*/} 1G backup.tar.gz"
  echo
  exit 1
  }

[ -f "${2}" ] || {
  echo "ER: file '${2}' does not exist"
  exit 1
  }

case $( uname ) in
  (FreeBSD)
    split -a 3 -b ${1} "${2}" "${2}"___part_
    ;;
  (Linux)
    split -a 3 -b ${1} -d "${2}" "${2}"___part_
    ;;
esac
