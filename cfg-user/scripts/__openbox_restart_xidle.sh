#! /bin/sh

  killall -9 xidle 1> /dev/null 2> /dev/null

  env DISPLAY=:0 xidle -area 1 -delay 0 -nw -program '/usr/local/bin/caja --browser --no-desktop' 1> /dev/null 2> /dev/null &
  env DISPLAY=:0 xidle -area 1 -delay 0 -ne -program '/usr/local/bin/skippy-xd'                   1> /dev/null 2> /dev/null &
  env DISPLAY=:0 xidle -area 1 -delay 0 -sw -program '/usr/local/bin/leafpad'                     1> /dev/null 2> /dev/null &
  env DISPLAY=:0 xidle -area 1 -delay 0 -se -program '/home/vermaden/scripts/xterm.sh -e zsh'     1> /dev/null 2> /dev/null &

# xdotool behave_screen_edge top-left     exec caja --browser --no-desktop &
# xdotool behave_screen_edge top-right    exec skippy-xd                   &
# xdotool behave_screen_edge bottom-left  exec leafpad                     &
# xdotool behave_screen_edge bottom-right exec xterm.sh                    &


