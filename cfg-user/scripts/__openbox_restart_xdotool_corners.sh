#! /bin/sh


xdotool behave_screen_edge top-left     exec caja      &
xdotool behave_screen_edge top-right    exec skippy-xd &
xdotool behave_screen_edge bottom-left  exec leafpad   &
xdotool behave_screen_edge bottom-right exec xterm.sh  &

