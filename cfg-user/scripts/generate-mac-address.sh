#! /bin/sh

LC_ALL=C

tr -c -d '0-9a-f' < /dev/urandom \
  | head -c 12 \
  | sed -e 's|\(..\)|\1:|g' -e 's|:$||'
