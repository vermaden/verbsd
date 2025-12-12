#! /bin/sh

if [ ${#} -eq 0 ]
then
  echo "usage: ${0##*/} FILE1 FILE2 ... FILEN"
  echo
  exit 1
fi

for FILE in "${@}"
do
  D=${FILE%/*}
  B=${FILE##*/}
  LOWER="$( echo "${B}" | tr '[:upper:]' '[:lower:]' )"

  if [ "${D}" = "${B}" ]
  then
    # TWO STEPS REQUIRED FOR FAT/PCFS FILESYSTEM
    mv "${B}" "tmp_${B}_tmp"
    mv        "tmp_${B}_tmp" "${LOWER}"
    continue
  fi

  if [ "${D}/${B}" = "./." ]
  then
    continue
  fi

  if [ "${D}/${B}" = "${D}/${LOWER}" ]
  then
    continue
  fi

  if [ -e "${D}/${B}" ]
  then
    # TWO STEPS REQUIRED FOR FAT/PCFS FILESYSTEM
    mv "${D}/${B}" "${D}/tmp_${B}_tmp"
    mv             "${D}/tmp_${B}_tmp" "${D}/${LOWER}"
  fi
done
