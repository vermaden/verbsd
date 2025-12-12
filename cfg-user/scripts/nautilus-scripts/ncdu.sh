#! /bin/sh

cd "$( echo ${NAUTILUS_SCRIPT_CURRENT_URI} | sed -E s/'[a-z]+:\/\/'//g -e s/%20/\ /g )" && xterm -geometry 160x40 -e ncdu

# GNOME2 : ~/.gnome2/nautilus-scripts/
# MATE   : ~/.config/caja/scripts/

# GNOME2 : NAUTILUS_SCRIPT_CURRENT_URI
# MATE   : NAUTILUS_SCRIPT_CURRENT_URI / CAJA_SCRIPT_CURRENT_URI
