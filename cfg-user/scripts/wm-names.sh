#!/bin/sh

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
# GET xprop(1) VALUES
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

XMESSAGE=xmessage

string=`xprop WM_CLASS WM_NAME WM_WINDOW_ROLE | grep -v 'not found'`

echo -n ${string} | grep -q WM_WINDOW_ROLE
if [ ${?} -eq 0 ]; then
     wm_role=`echo -n ${string} | cut -d '"' -f 2`
  wm_class_1=`echo -n ${string} | cut -d '"' -f 4`
  wm_class_2=`echo -n ${string} | cut -d '"' -f 6`
     wm_name=`echo -n ${string} | cut -d '"' -f 8`
else
  wm_class_1=`echo -n ${string} | cut -d '"' -f 2`
  wm_class_2=`echo -n ${string} | cut -d '"' -f 4`
     wm_name=`echo -n ${string} | cut -d '"' -f 6`
fi

# PRINT ON TERMINAL OUTPUT
echo "available properties:"
echo
echo " xprop   fluxbox   value"
echo " -----   -------   -----"
echo " CLASS1   name     ${wm_class_1}"  # first field of WM_CLASS
echo " CLASS2   class    ${wm_class_2}"  # second field of WM_CLASS
echo "  NAME    title    ${wm_name}"     # WM_NAME property
if [ ${wm_role} ]
then
  echo "  ROLE    role     ${wm_role}"   # WM_WINDOW_ROLE property
fi

# PRINT WITH xmessage(1) WINDOW
(
  echo "available properties:"
  echo
  echo " xprop   fluxbox   value"
  echo " -----   -------   -----"
  echo " CLASS1   name     ${wm_class_1}"  # first field of WM_CLASS
  echo " CLASS2   class    ${wm_class_2}"  # second field of WM_CLASS
  echo "  NAME    title    ${wm_name}"     # WM_NAME property
  if [ ${wm_role} ]
  then
    echo "  ROLE    role     ${wm_role}"   # WM_WINDOW_ROLE property
  fi
) | ${XMESSAGE} -title "available properties" -file - -center

