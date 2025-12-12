#! /bin/sh

case ${#} in
  (1) TARGET="${1}" ;;
  (0) TARGET="."    ;;
esac

find "${TARGET}" -mindepth 1 -type d \
  | sort -r \
  | while read I
    do
      to-ascii.sh "${I}"
    done

find "${TARGET}" -mindepth 1 -not -type d \
  | sort -r \
  | while read I
    do
      to-ascii.sh "${I}"
    done
