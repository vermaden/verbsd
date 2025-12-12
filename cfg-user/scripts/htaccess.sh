#! /bin/sh

# FORMAT: user:CRYPT(pass)

if [ ${#} -ne 1 ]
then
  echo "${0##*/} user"
  exit 1
fi

STTY=$( stty -g )
echo -n "Password: " 1>&2
stty -echo
read PASS
stty ${STTY}

PASS=$( openssl passwd -crypt "${PASS}" )

echo
echo
echo ${1}:${PASS}
