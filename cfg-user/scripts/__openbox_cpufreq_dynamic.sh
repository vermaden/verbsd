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
# openbox(1) WITH cpufreq(4)
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

SUDO_WHICH=0
SUDO=0
DOAS_WHICH=0
DOAS=1
ROOT=0

# CHECK doas(8) WITH which(1)
if which doas 1> /dev/null 2> /dev/null
then
  DOAS_WHICH=1
else
  DOAS_WHICH=0
fi

# CHECK sudo(8) WITH which(1)
if which sudo 1> /dev/null 2> /dev/null
then
  SUDO_WHICH=1
else
  SUDO_WHICH=0
fi

# CHECK USER WITH whoami(1)
if [ "$( whoami )" = "root" ]
then
  ROOT=1
fi

# CHOOSE ONE FROM doas(8) AND sudo(8)
if [ ${DOAS_WHICH} -eq 1 -o ${SUDO_WHICH} -eq 1 ]
then
  if [   ${DOAS} -eq 0 -a ${SUDO} -eq 1 -a ${SUDO_WHICH} -eq 1 ]
  then
    CMD=sudo
  elif [ ${DOAS} -eq 1 -a ${SUDO} -eq 0 -a ${DOAS_WHICH} -eq 1 ]
  then
    CMD=doas
  elif [ ${DOAS} -eq 1 -a ${SUDO} -eq 1 -a ${DOAS_WHICH} -eq 1 ]
  then
    CMD=doas
  fi
elif [ ${ROOT} -eq 1 ]
then
  CMD=''
else
  echo "NOPE: This script needs 'doas' or 'sudo' to work properly."
  exit 1
fi

unset SUDO_WHICH
unset DOAS_WHICH
unset ROOT

__usage() {
  echo "usage: ${0##*/} MIN MAX"
  echo
  echo "example:"
  echo "  ${0##*/}   0    0  --  disabled powerd/powerdxx and sets speed to 800MHz"
  echo "  ${0##*/} 800 1400  --  sets minimum to 800MHz and maximum to 1.4GHz"
  echo "  ${0##*/} 800 +200  --  sets minimum to 800MHz and maximum incresed by 200MHz"
  echo "  ${0##*/} 800 -200  --  sets minimum to 800MHz and maximum decresed by 200MHz"
  exit 1
}

[ ${#} -ne 2 ] && __usage

# FreeBSD 6.0 - 8.1
# sysctl debug.cpufreq.highest=${1}

# FreeBSD 8.2 - CURRENT

if [ "${1}" = "0" -a "${2}" = "0" ]
then
  ${CMD} service powerdxx onestop 1> /dev/null 2> /dev/null
  ${CMD} service powerd   onestop 1> /dev/null 2> /dev/null
  ${CMD} killall -9 powerd++ powerd
  ${CMD} sysctl dev.cpu.0.freq=800
else
  case ${2} in
    (+*|-*)
      MAX_FILE=$( grep powerd_flags /etc/rc.conf | awk -F\" '{print $2}' | grep -E -o -- '-M[\ ]*[0-9]+' | tr -c -d '0-9' )
      MAX_NEW=$(( ${MAX_FILE} + ${2} ))
      FLAGS="-n adaptive -a hiadaptive -b adaptive -m ${1} -M ${MAX_NEW}"
      ;;
    (*)
      FLAGS="-n adaptive -a hiadaptive -b adaptive -m ${1} -M ${2}"
      ;;
  esac
  POWERDXX_FLAGS="powerdxx_flags=\"${FLAGS}\""
  POWERD_FLAGS="powerd_flags=\"${FLAGS}\""
  ${CMD} sed -i -E s/"powerd_flags.*$"/"${POWERD_FLAGS}"/g     /etc/rc.conf
  ${CMD} sed -i -E s/"powerdxx_flags.*$"/"${POWERDXX_FLAGS}"/g /etc/rc.conf
  ${CMD} service powerd   restart 1> /dev/null 2> /dev/null
  ${CMD} service powerdxx restart 1> /dev/null 2> /dev/null
fi
