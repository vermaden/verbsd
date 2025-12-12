#! /bin/sh

# Copyright (c) 2018 Slawomir Wojciech Wojtczak (vermaden)
# All rights reserved.
#
# THIS SOFTWARE USES FREEBSD LICENSE (ALSO KNOWN AS 2-CLAUSE BSD LICENSE)
# https://www.freebsd.org/copyright/freebsd-license.html
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------
# SIMPLE LOCK MECHANISM
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

LOCK="${0}.LOCK"
DELAY=30
COUNT=0

__usage() {
  echo "usage: ${0##*/} OPTION"
  echo
  echo "  OPTIONS:"
  echo "    create"
  echo "    status"
  echo "    remove"
  echo
  exit 1
}

__status() {
  if [ -e "${LOCK}" ]
  then
    echo "INFO: LOCK file '${LOCK}' present"
    return 1
  else
    echo "INFO: LOCK file '${LOCK}' not present"
    return 0
  fi
}

if [ ${#} -ne 1 ]
then
  __usage
fi

case ${1} in

  (create)
    if __status 1> /dev/null 2> /dev/null
    then
      # LOCK NOT PRESENT
      :> "${LOCK}"
      if ! __status 1> /dev/null 2> /dev/null
      then
        echo "INFO: LOCK file '${LOCK}' created"
      else
        echo "ERROR: can not create '${LOCK}' file"
        exit 1
      fi
      exit 0
    else
      # LOCK PRESENT
      while sleep 1
      do
        COUNT=$(( ${COUNT} + 1 ))
        if [ ${COUNT} -gt ${DELAY} ]
        then
          exit 1
          # "${0}" remove
          break
        fi
        echo "INFO: waiting ${COUNT} seconds"
      done
    fi
    ;;

  (status)
    __status
    exit 0
    ;;

  (remove)

   if __status 1> /dev/null 2> /dev/null
    then
      # LOCK NOT PRESENT
      echo "INFO: LOCK file '${LOCK}' not present"
    else
      # LOCK PRESENT
      rm -f "${LOCK}"
      echo "INFO: LOCK file '${LOCK}' removed"
    fi
    ;;

  (*)
    __usage
    ;;

esac
