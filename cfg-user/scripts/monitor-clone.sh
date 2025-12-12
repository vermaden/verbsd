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
# clone internal display to external one
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

# OUTPUTS
INT=LVDS-1
EXT=VGA-1

__usage() {
  NAME=${0##*/}
  echo "usage: ${NAME} [VIEWPORT]"
  echo
  echo "  examples:"
  echo "    ${NAME}"
  echo "    ${NAME} 1920x1200"
  echo "    ${NAME} 1920x1080"
  echo "    ${NAME} reset"
  echo
  unset NAME
  exit 1
}

__resize() {
  # RESIZE TASKBARS/STATUSBARS/WALLPAPERS
  echo "INFO: ~/scripts/__openbox_restart_dzen2.sh"
              ~/scripts/__openbox_restart_dzen2.sh
  echo "INFO: ~/scripts/__openbox_restart_tint2.sh"
              ~/scripts/__openbox_restart_tint2.sh
  echo "INFO: ~/scripts/random-wallpaper-always.sh ~/gfx/wallpapers"
              ~/scripts/random-wallpaper-always.sh ~/gfx/wallpapers
}

# WE HAVE MORE THEN TWO (2) DISPLAYS
DISPLAYS=$( xrandr | grep -c ' connected ' )
if [ "${DISPLAYS}" != "2" ]
then
  echo "NOPE: This script requires two (2) screens in the system."
  echo
  __usage
fi
unset DISPLAYS

if [ ${#} -ne 0 ]
then
  case ${1} in
    (-h|--h|-help|--help)
      __usage
      ;;
    (reset)
      echo "INFO: xrandr -s 0"
                  xrandr -s 0
      # RESIZE AFTER RESET
      __resize
      exit 0
      ;;
    (*)
      # SET VIRTUAL RESOLUTION TO FIRST ARGUMENT
      VIR=${1}
      ;;
  esac
else
  # GET RESOLUTION FOR EXTERNAL DISPLAY
  VIR=$( xrandr | grep -A 1 "${EXT} connected " | awk 'END{print $1}' )
fi

# GET RESOLUTION FOR INTERNAL SCREEN
RES=$( xrandr | grep -A 1 "${INT} connected " | awk 'END{print $1}' )

# CLONE INTERNAL DISPLAY TO EXTERNAL
echo "INFO: xrandr --output ${INT} --mode ${RES} --panning ${VIR}"
            xrandr --output ${INT} --mode ${RES} --panning ${VIR}
echo "INFO: xrandr --output ${EXT} --mode ${VIR}"
            xrandr --output ${EXT} --mode ${VIR}
echo "INFO: xrandr --output ${EXT} --same-as ${INT}"
            xrandr --output ${EXT} --same-as ${INT}
unset VIR
unset RES
unset INT
unset EXT

# RESIZE AFTER CLONE
__resize
