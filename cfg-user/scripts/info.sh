#! /bin/sh

__usage() {
  echo "usage: $( basename "${0}" ) FILE"
  echo
  exit 1
}

if [ -f "${@}" ]
then

  echo
  echo "// mediainfo(1)"
  echo "// ============================================================================"
  mediainfo "${@}" 2> /dev/null \
    | grep -v -e '^Encoding settings' -e '^Unique ID' \
    | grep --color=always -C 999 -e '^Audio' -e '^Video' -e '^General' -e '^Text' -e "${@}"
  echo

  echo
  echo "// ffmpeg(1)"
  echo "// ============================================================================"
  ffmpeg -hide_banner -i "${@}" 2>&1 \
    | grep -v -e 'At least one output file must be specified' \
    | grep -v -e 'Invalid data found when processing input' \
    |  tr ',' '\n' \
    | grep --color=always -C 999 -e ' Audio: ' -e ' Video: ' -e ' Subtitle: ' -e ' Stream ' -e 'Metadata: ' -e "${@}"
  echo

else
  __usage
fi

read null
