#! /bin/sh

pgrep urxvtd 1> /dev/null 2> /dev/null || urxvtd &

urxvtc &
