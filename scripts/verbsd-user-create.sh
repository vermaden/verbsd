#! /bin/sh

# LOAD SETTINGS
if [ -f verbsd-settings.sh ]
then
  . verbsd-settings.sh || . ./verbsd-settings.sh
else
  echo "NOPE: the 'verbsd-settings.sh' is not available"
  exit 1
fi

# CREATE USER
echo "INFO: trying to create the '${THEUSER}' user"
chroot "${BEDIR}" \
  /usr/bin/env pw userdel -n ${THEUSER} -r 1> /dev/null 2> /dev/null
chroot "${BEDIR}" \
  /usr/bin/env pw useradd ${THEUSER} \
    -c ${THEUSER} \
    -u ${THEUSERUID} \
    -d ${THEUSERDIR} \
    -G ${THEUSERGRP} \
    -s /usr/local/bin/zsh \
      || __error "could not create '${THEUSER}' user"
echo "INFO: user '${THEUSER}' created"

# SET USER PASSWORD
echo "INFO: setting password for '${THEUSER}' user"
echo "${THEUSERPASSWD}" \
  | chroot "${BEDIR}" \
      /usr/bin/env pw usermod -n ${THEUSER} -h 0

exit 0

# pw useradd vermaden -u 1000 -d /home/vermaden -G wheel,operator,video,network,webcamd,vboxusers,realtime,idletime,cups,pulse-rt,pulse,pulse-access
# passwd root
# passwd vermaden
