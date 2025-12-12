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
# DZEN2
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

__math() {
  local SCALE=1
  local RESULT=$( echo "scale=${SCALE}; ${@}" | bc -l )
  if echo ${RESULT} | grep --color -q '^\.'
  then
    echo -n 0
  fi
  echo ${RESULT}
  unset SCALE
  unset RESULT
}

DELAY=2
FONT='Ubuntu Mono-10'
FG='#eeeeee'
BG='#222222'
CLA='^fg(#aaaaaa)'
CVA='^fg(#eeeeee)'
CDE='^fg(#dd0000)'

while :
do
  DATE=$( date +%Y/%m/%d/%a/%H:%M )
  FREQ=$( sysctl -n dev.cpu.0.freq )
  TEMP=$( sysctl -n hw.acpi.thermal.tz0.temperature )
  LOAD=$( sysctl -n vm.loadavg | awk '{print $2}' )
  MEM=$(( $( sysctl -n vm.stats.vm.v_inactive_count )
        + $( sysctl -n vm.stats.vm.v_free_count )
        + $( sysctl -n vm.stats.vm.v_cache_count ) ))
  MEM=$( __math ${MEM} \* 4 / 1024 / 1024 )
  IF_IP=$( ~/scripts/__conky_if_ip.sh )
  IF_GW=$( ~/scripts/__conky_if_gw.sh )
  IF_DNS=$( ~/scripts/__conky_if_dns.sh )
  IF_PING=$( ~/scripts/__conky_if_ping.sh dzen2 )
  VOL=$( mixer -s vol | awk -F ':' '{printf("%s",$2)}' )
  PCM=$( mixer -s pcm | awk -F ':' '{printf("%s",$2)}' )
  FS=$( zfs list -H -d 0 -o name,avail | awk '{printf("%s/%s ",$1,$2)}' )
  BAT=$( ~/scripts/__conky_battery.sh dzen2 )
  PS=$( ps ax -o %cpu,rss,comm | sed 1d | bsdgrep -v 'idle$' | sort -r -n \
          | head -3 | awk '{printf("%s/%d%%/%.1fGB ",$3,$1,$2/1024/1024)}' )
  echo -n        " ${CLA}date: ${CVA}${DATE} "
  echo -n "${CDE}| ${CLA}sys: ${CVA}${FREQ}MHz/${TEMP}/${LOAD}/${MEM}GB "
  echo -n "${CDE}| ${CLA}ip: ${CVA}${IF_IP}"            # NO SPACE AT THE END
  echo -n "${CDE}| ${CLA}gw: ${CVA}${IF_GW} "
  echo -n "${CDE}| ${CLA}dns: ${CVA}${IF_DNS} "
  echo -n "${CDE}| ${CLA}ping: ${CVA}${IF_PING} "
  echo -n "${CDE}| ${CLA}vol/pcm: ${CVA}${VOL}/${PCM} "
  echo -n "${CDE}| ${CLA}fs: ${CVA}${FS}"               # NO SPACE AT THE END
  echo -n "${CDE}| ${CLA}bat: ${CVA}${BAT} "
  echo -n "${CDE}| ${CLA}top: ${CVA}${PS}"
  echo
  sleep ${DELAY}
done \
  | dzen2 \
      -fg "${FG}" \
      -bg "${BG}" \
      -fn "${FONT}" \
      -ta l \
      -e 'onstart=lower;button1=exec:~/scripts/dzen2-update.sh;button2=exec:~/scripts/xdotool.sh workmenu;button3=exec:~/scripts/xdotool.sh menu;button4=exec:~/scripts/xdotool.sh down;button5=exec:~/scripts/xdotool.sh up' &
