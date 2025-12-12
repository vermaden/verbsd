#! /bin/sh

find . -type d | sort -r | while read D
do
  [ "${D}" = "."  ] && continue
  [ "${D}" = ".." ] && continue
  DIRNAME=$( dirname "${D}" )
  BASENAME=$( basename "${D}" )
  [ "${D}" = "${DIRNAME}/$( echo ${BASENAME} | tr '[:upper:]' '[:lower:]' )" ] && continue
  if [ "${DIRNAME}" = "$( echo ${BASENAME} | tr '[:upper:]' '[:lower:]' )" ]
  then
    mv -v "${D}" "$( echo ${D} | tr '[:upper:]' '[:lower:]' )"
  else
    mv -v "${D}" "${DIRNAME}/$( echo ${BASENAME} | tr '[:upper:]' '[:lower:]' )"
  fi
done

unset DIRNAME
unset BASENAME

find . -type f | sort -r  | while read F
do
  DIRNAME=$( dirname "${F}" )
  BASENAME=$( basename "${F}" )
  [ "${F}" = "${DIRNAME}/$( echo ${BASENAME} | tr '[:upper:]' '[:lower:]' )" ] && continue
  mv -v "${F}" "${DIRNAME}/$( echo ${BASENAME} | tr '[:upper:]' '[:lower:]' )"
done
