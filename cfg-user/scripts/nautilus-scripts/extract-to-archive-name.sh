#! /bin/sh

__usage() {
  NAME=$( basename ${0} )
  echo "usage: ${NAME} FILE"
  exit 1
}

[ ${#} -ne 1  ] && __usage
[ ! -f "${1}" ] && __usage

DIRNAME=$( echo "${1}" | sed 's/\..*$//g' )

cd "$( echo ${CAJA_SCRIPT_CURRENT_URI} \
         | sed -E                      \
               -e s/'[a-z]+:\/\/'//g   \
               -e s/'%20'/\ /g         \
               -e s/'%5B'/\[/g         \
               -e s/'%5D'/\]/g  )"

engrampa --extract-here "${1}"

# xterm -e "to-ascii-all.sh \"${DIRNAME}\"; read"

