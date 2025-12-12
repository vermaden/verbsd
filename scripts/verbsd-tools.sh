#! /bin/sh

# LOAD SETTINGS
if [ -f verbsd-settings.sh ]
then
  . verbsd-settings.sh || . ./verbsd-settings.sh
else
  echo "NOPE: the 'verbsd-settings.sh' is not available"
  exit 1
fi

# INSTALL NEEDED TOOLS
echo "INFO: trying to install needed tools"
/usr/bin/env ASSUME_ALWAYS_YES=yes pkg install -y beadm 1> /dev/null 2> /dev/null \
  || __error "could not install 'beadm(8)' package"
echo "INFO: package 'beadm' installed"

# MOUNT NEW BE
echo "INFO: trying to mount '${BE}' BE on '${BEDIR}' dir"
beadm mount "${BE}" "${BEDIR}" 1> /dev/null 2> /dev/null
echo "INFO: BE '${BE}' mounted on '${BEDIR}' dir"
