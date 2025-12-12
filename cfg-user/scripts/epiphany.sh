#! /bin/sh

__usage() {
  echo "usage: ${0##*/} FILE"
  exit 1
}

if [ ${#} -ne 1 ]
then
  __usage
fi

if [ ! -f "${@}" ]
then
  echo "ERROR: file '${@}' does not exists."
  __usage
fi

epiphany -p "${@}" &
