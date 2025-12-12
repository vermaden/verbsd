#! /bin/sh

if [ ${#} -ne 1 ]
then
  echo "usage: ${0##*/} FILE"
  echo
  exit 1
fi

if [ ! -f "${1}" ]
then
  echo "NOPE: file '${1}' does not exists"
  exit 1
fi

# TWO STEPS REQUIRED FOR FAT/PCFS FILESYSTEM
HYPEN=$( echo "${1}" | tr ' ' '-' | tr '_' '-' )
mv "${1}" "${HYPEN}_tmp"
mv        "${HYPEN}_tmp" "${HYPEN}"

