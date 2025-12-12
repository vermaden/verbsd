#! /bin/sh

if [ ${#} -eq 0 ]
then
  echo "usage: ${0##*/} FILE1 FILE2 ... FILEN"
  echo
  exit 1
fi

for FILE in "${@}"
do
  # TWO STEPS REQUIRED FOR FAT/PCFS FILESYSTEM
  D=${FILE%/*}
  B=${FILE##*/}
  BRACKET=$( echo "${B}" |  tr -d '()' )
  mv "${D}/${B}" "${D}/tmp_${B}_tmp"
  mv             "${D}/tmp_${B}_tmp" "${D}/${BRACKET}"
done
