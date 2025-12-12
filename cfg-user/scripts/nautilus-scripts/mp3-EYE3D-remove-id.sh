#! /bin/sh

  cd "$( echo ${NAUTILUS_SCRIPT_CURRENT_URI} | sed -E s/'[a-z]+:\/\/'//g -E s/'%20'/\ /g )"
# xterm -e "find . -iname \*.mp3 -exec echo eyeD3 --remove-all \\\"{}\\\" ';' | parallel -j 2; echo ; echo "DONE." ; read"
  xterm -e "find . -iname \*.mp3 -exec echo id3v2 --delete-all \\\"{}\\\" ';' | parallel -j 4; echo ; echo "DONE." ; read"
