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
# openbox(1) CUSTOM FULLSCREEN
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

OVERHEAD_X=5
MARGIN_TOP=31
MARGIN_LEFT=1
MARGIN_BOTTOM=62

# DUAL/SINGLE
case $( xrandr -q | grep -c ' connected ' ) in
  (2)
  wmctrl -r :ACTIVE: -e 0,$(( ${MARGIN_LEFT} + 1920 )),28,$(( 1917 - ${MARGIN_LEFT} )),1152
  ;;

  (1)
  RESOLUTION=$( xrandr \
          | grep -v disconnected \
          | grep connected \
          | awk '{print $3}' \
          | awk -F'+'  '{print $1}' \
          | sed s/x/\ /g )
  RESOLUTION_X=$( echo "${RESOLUTION}" | awk '{print $1}' )
  RESOLUTION_Y=$( echo "${RESOLUTION}" | awk '{print $2}' )

  # DEBUG
  # RESOLUTION_X=$(( 1920 - 40 - 4 ))
  # RESOLUTION_Y=$(( 1080 - 48 ))

  wmctrl -r :ACTIVE: -e 0,$(( ${MARGIN_LEFT} )),${MARGIN_TOP},$(( ${RESOLUTION_X} - ${MARGIN_LEFT} - ${OVERHEAD_X} )),$(( ${RESOLUTION_Y} - ${MARGIN_BOTTOM} ))

esac
