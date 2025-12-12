#! /bin/sh

# GNOME2 : ~/.gnome2/nautilus-scripts/
# MATE   : ~/.config/caja/scripts/

# GNOME2 : NAUTILUS_SCRIPT_CURRENT_URI
# MATE   : NAUTILUS_SCRIPT_CURRENT_URI / CAJA_SCRIPT_CURRENT_URI

# DEBUG
# echo ${NAUTILUS_SCRIPT_CURRENT_URI}                                                                                             >> ~/tmp
# echo "$( echo ${NAUTILUS_SCRIPT_CURRENT_URI} | sed -E -e s/'[a-z]+:\/\/'//g -e s/'%20'/\ /g -e s/'%5B'/\[/g -e s/'%5D'/\]/g  )" >> ~/tmp
# echo                                                                                                                            >> ~/tmp

cd "$( echo ${NAUTILUS_SCRIPT_CURRENT_URI} \
         | sed -E \
               -e s/'[a-z]+:\/\/'//g \
               -e s/'%20'/\ /g \
               -e s/'%5B'/\[/g \
               -e s/'%5D'/\]/g  )" && ~/scripts/xterm.sh -e zsh
