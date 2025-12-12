#! /bin/sh

TMP1="/tmp/${0##*/}_path1.tmp"
TMP2="/tmp/${0##*/}_path2.tmp"

__usage() {
  echo "usage: ${0##*/} PATH PATH"
  echo "example: ${0##*/} /mnt/BACKUP /storage"
  echo
  exit 1
  }

__exit() {
  rm -rf ${TMP1} ${TMP2}
  }

__dir() {
  [ -d ${1} ] || {
    echo "ER: dir '${1}' does not exist"
    exit 1
    }
  }

__compare() {
  cd ${1} && find . -type d | sort -u > ${TMP1}
  cd ..
  cd ${2} && find . -type d | sort -u > ${TMP2}
  cd ..
  diff ${TMP1} ${TMP2} | egrep "^(<|>).*" | sed -e s/\</1:/g -e s/\>/2:/g | sort -n
  echo
  echo "0: INFO"
  echo "1: dir only in '${1}'"
  echo "2: dir only in '${2}'"
  echo "3: compared dir '${3}'"
  }

trap '__exit' 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

case ${#} in
  (2)
    __dir ${1}
    __dir ${2}
    __compare ${1} ${2}
    ;;
  (*)
    __usage
    ;;
esac
