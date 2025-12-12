#! /bin/sh

PATH=${PATH}:~/scripts:~/bin

STTY=$( stty -g )
echo -n "Password: " 1>&2
stty -echo
read PASS
stty ${STTY}
echo

gpart-geli-devices.sh \
  | while read I
    do
      echo -n "${I} "
      echo -n "${PASS}" | geli attach -j - -d ${I}
      if [ ${?} -eq 0 ]
      then
        echo DONE
      else
        echo NOPE
      fi
    done
