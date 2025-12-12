#! /bin/sh

__pkg_deps() { # 1=PACKAGE_NAME
  while read I
  do
    if [ "${I}" = "" ]
    then
      break
    fi
    NAME=$( pkg info -o ${I} | awk '{print $NF}' )
    echo ${NAME}
    __pkg_deps ${I}
  done << EOF
$( pkg info -d ${1} | sed 1d )
EOF
}

(
  if [ "${1}" != "" ]
  then
    __pkg_deps ${1}
    exit 0
  fi

  while read I
  do
    echo ${I}
    __pkg_deps ${I}
  done << EOF
  $( pkg info -qoa )
EOF
) | sort -u


