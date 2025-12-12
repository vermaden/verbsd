#! /bin/sh

xterm -e "unrar x \"$@\"; read"

# zenity --title="UnRAR" --info --text="Archive '${@}' Extracted."
