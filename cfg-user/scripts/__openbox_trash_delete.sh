#! /bin/sh

mount -p \
  | awk '{print $2}' \
  | while read I
    do
      rm -rf "${I}/.Trash-1000"
    done

rm -r -f ~/.local/share/Trash/files
