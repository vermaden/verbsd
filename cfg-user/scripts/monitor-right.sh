#! /bin/sh

if [ ${#} -ne 1 ]
then
  echo "usage: ${0##*/} on|off"
  exit 1
fi

# LEFT
# xrandr \
#   --output LVDS-0 \
#     --mode 1920x1080 \
#     --pos 1920x64 \
#   --output DP-1 \
#     --mode 1920x1200 \
#     --pos 0x0

case ${1} in
  (on|1|start|add)
  # ADD SCREEN
    xrandr --output DP-1 --right-of LVDS-0 --mode 1920x1200
    xrandr --output DP-1 --primary
    xrandr --output DP-1 --preferred
    # xrandr --noprimary
    ;;

  (off|0|stop|del|delete|rem|remove)
  # MOVE WINDOWS TO FIRST SCREEN
    X_INIT=40
    Y_INIT=40
    STEP=17
    wmctrl -lG \
      | awk '{print $1, $5, $6}' \
      | while read WINDOW X Y
        do
          wmctrl -i -r ${WINDOW} -e 0,${X_INIT},${Y_INIT},${X},${Y}
          X_INIT=$(( ${X_INIT} + ${STEP} ))
          Y_INIT=$(( ${Y_INIT} + ${STEP} ))
          if [ ${X_INIT} -gt 1800 ]
          then
            X_INIT=1800
          fi
          if [ ${Y_INIT} -gt 1800 ]
          then
            Y_INIT=1800
          fi
        done
    xrandr --output DP-1 --off 1> /dev/null 2> /dev/null
    ;;

esac

# RESTART DAEMONS
  ~/scripts/__openbox_restart_tint2.sh
  ~/scripts/__openbox_restart_conky.sh
  ~/scripts/__openbox_restart_plank.sh
  ~/scripts/__openbox_reload_wallpaper.sh
# ~/scripts/random-wallpaper-always.sh ~/gfx/wallpapers &
