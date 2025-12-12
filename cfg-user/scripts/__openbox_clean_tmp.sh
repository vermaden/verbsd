doas rm -rf \
  /tmp/simple-mtpfs-* \
  /tmp/Audacity_* \
  /tmp/dbus-* \
  /tmp/gimp* \
  /tmp/pulse-* \
  /tmp/*cache*

doas find /tmp -mtime +3 -delete
