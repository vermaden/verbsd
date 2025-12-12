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
# MINIMIZE WINDOWS ON CURRENT DESKTOP
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

CURRENT_DESKTOP=$( wmctrl -d | egrep "^[0-9][ ]{2}\*" | awk '{print $1}' )
WINDOW_LIST=$( wmctrl -l | egrep "^[0-9]x.{8}\ {2}${CURRENT_DESKTOP}" | awk '{print $1}' )

WINDOW_COUNT=0
for WINDOW in ${WINDOW_LIST} ;do
   WINDOW_COUNT=$(( ${WINDOW_COUNT} + 1 ))
done

minimize () {
  for WINDOW in ${WINDOW_LIST}; do
    wmctrl -t ${CURRENT_DESKTOP} -i -r ${WINDOW} -b add,hidden
  done
  }

restore () {
  for WINDOW in ${WINDOW_LIST}; do
    wmctrl -t ${CURRENT_DESKTOP} -i -r ${WINDOW} -b remove,hidden
  done
  }

MINIMIZED=0
for WINDOW in ${WINDOW_LIST}; do
  if xprop -id ${WINDOW} _NET_WM_STATE | grep -q NET_WM_STATE_HIDDEN; then
    MINIMIZED=$(( ${MINIMIZED} + 1 ))
  fi
done

if [ ${MINIMIZED} -eq ${WINDOW_COUNT} ]; then
  restore
else
  minimize
fi
