#! /bin/sh

if [ ${#} -eq 1 ]
then
  TARGET="${1}"
else
  TARGET=.
fi

find "${TARGET}" -type d -depth 1 \
  | while read DIR
    do
      find "${DIR}" -type f \
        | wc -l \
        | tr '\n' ' '
      echo "${DIR}" \
        | cut -c 3-999
    done | sort -n
