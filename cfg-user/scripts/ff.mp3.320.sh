#! /bin/sh

ffmpeg -y -i "${@}" -acodec libmp3lame -threads 1 -ab 320k -ar 44100 -aq 2 "${@}".mp3
