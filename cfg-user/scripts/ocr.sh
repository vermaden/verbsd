#! /bin/sh

__usage() {
  NAME=$( basename ${0} )
  echo "usage: ${NAME} FILE"
  exit 1
}

if [ ! -f "${1}" ]
then
  __usage
fi

if [ -f "${1}".txt ]
then
  echo    "INFO: file '${1}.txt' already exists"
  echo -n "READ: overwrite? (y/n): "
  read YESNO

  case ${YESNO} in
    (Y|YES|y|yes|OK|ok) ;;
    (*)
      echo "NOPE: user did not wanted to continue"
      exit 1
      ;;
  esac
fi

echo "INFO: OCR for '${1}' file in progress ..."

tesseract "${1}" "${1}" 1> /dev/null 2> /dev/null

if [ "${?}" = "0" ]
then
  echo "INFO: file after OCR available as: ${1}.txt"
else
  echo "NOPE: failed to OCR the '${1}' file"
  exit 1
fi

