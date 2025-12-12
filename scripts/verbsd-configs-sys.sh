#! /bin/sh

# LOAD SETTINGS
if [ -f verbsd-settings.sh ]
then
  . verbsd-settings.sh || . ./verbsd-settings.sh
else
  echo "NOPE: the 'verbsd-settings.sh' is not available"
  exit 1
fi

# SYSTEM CONFIGS
echo "INFO: trying to copy system configs to target destinations"

# CHANGE TO cfg-sys DIR
cd ../cfg-sys || __error "can not cd(1) to 'cfg-sys' dir"

# FIND AND RECREATE DIRS
find . -type d \
  | while read I
    do
      mkdir -pv ${BEDIR}/${I} | awk '{print $NF}' || FAIL=1
    done

# FIND AND COPY FILES
find . -type f \
  | while read I
    do
      cp -v "${I}" ${BEDIR}/"${I}" | awk '{print $NF}' || FAIL=1
    done

# GET BACK FROM cfg-sys DIR
cd -

# CHECK PROBLEMS AND REPORT POTENTIAL ERRORS
if [ "${FAIL}" = "1" ]
then
  __error "failed to copy at least one config into '${BEDIR}' BE"
fi
echo "INFO: system configs copied to target destinations"

# APPLY PROPER chown(8) PERMISSIONS
echo "INFO: trying to chown(8) correct permissions"
chown -R 0:0 ${BEDIR}/boot          || FAIL=1
chown -R 0:0 ${BEDIR}/etc           || FAIL=1
chown -R 0:0 ${BEDIR}/usr/local/etc || FAIL=1

# CHECK PROBLEMS AND REPORT POTENTIAL ERRORS
if [ "${FAIL}" = "1" ]
then
  __error "failed to apply correct chown(8) permissions"
fi
echo "INFO: successfully applied chown(8) correct permissions"


