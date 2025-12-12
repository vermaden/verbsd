#! /bin/sh

__usage() {
  echo "usage: $( basename "${0}" ) FILE"
  echo
  exit 1
}

xterm -e "info.sh ${@}"

read null
