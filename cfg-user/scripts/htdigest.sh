#! /bin/sh

# FORMAT: user:realm:MD5(user:realm:pass)

if [ ${#} -ne 2 ]
then
  echo "${0##*/} user realm"
  exit 1
fi

STTY=$( stty -g )
echo -n "Password: " 1>&2
stty -echo
read PASS
stty ${STTY}

case $( uname ) in
  (FreeBSD) MD5=md5    ;;
  (Linux)   MD5=md5sum ;;
esac

PASS=$( echo -n "${1}:${2}:${PASS}" | ${MD5} )

echo
echo
echo ${1}:${2}:${PASS}
