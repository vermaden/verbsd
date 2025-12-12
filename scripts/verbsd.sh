#! /bin/sh

# WHEN USED WITH '-f' THEN REMOVE LOCKS
case ${1} in
  (-f)
    rm -f verbsd-*.LOCK
    ;;
esac

# PATH
export PATH="${PATH}:common"

# NEEDED TOOLS
if [ ! -f              verbsd-tools.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-tools.sh ] \
    &&                 verbsd-tools.sh 2> /dev/null \
    ||               ./verbsd-tools.sh
  [ ${?} -eq 0 ] && :> verbsd-tools.sh.LOCK
fi

# BE CREATION
if [ ! -f              verbsd-base-be.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-base-be.sh ] \
    &&                 verbsd-base-be.sh 2> /dev/null \
    ||               ./verbsd-base-be.sh
  [ ${?} -eq 0 ] && :> verbsd-base-be.sh.LOCK
fi

# DIST FILES FETCH AND VERIFY
if [ ! -f              verbsd-base-fetch.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-base-fetch.sh ] \
    &&                 verbsd-base-fetch.sh 2> /dev/null \
    ||               ./verbsd-base-fetch.sh
  [ ${?} -eq 0 ] && :> verbsd-base-fetch.sh.LOCK
fi

# EXTRACT DIST FILES
if [ ! -f              verbsd-base-extract.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-base-extract.sh ] \
    &&                 verbsd-base-extract.sh 2> /dev/null \
    ||               ./verbsd-base-extract.sh
  [ ${?} -eq 0 ] && :> verbsd-base-extract.sh.LOCK
fi

# INSTALL PACKAGES
if [ ! -f              verbsd-packages.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-packages.sh ] \
    &&                 verbsd-packages.sh 2> /dev/null \
    ||               ./verbsd-packages.sh
  [ ${?} -eq 0 ] && :> verbsd-packages.sh.LOCK
fi

# CREATE USER
if [ ! -f              verbsd-user-create.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-user-create.sh ] \
    &&                 verbsd-user-create.sh 2> /dev/null \
    ||               ./verbsd-user-create.sh
  [ ${?} -eq 0 ] && :> verbsd-user-create.sh.LOCK
fi

# CONFIGS FETCH
if [ ! -f              verbsd-configs-fetch.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-configs-fetch.sh ] \
    &&                 verbsd-configs-fetch.sh 2> /dev/null \
    ||               ./verbsd-configs-fetch.sh
  [ ${?} -eq 0 ] && :> verbsd-configs-fetch.sh.LOCK
fi

# CONFIGS SYSTEM
if [ ! -f              verbsd-configs-sys.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-configs-sys.sh ] \
    &&                 verbsd-configs-sys.sh  2> /dev/null \
    ||               ./verbsd-configs-sys.sh
  [ ${?} -eq 0 ] && :> verbsd-configs-sys.sh.LOCK
fi

# CONFIGS USER
if [ ! -f              verbsd-configs-user.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-configs-user.sh ] \
    &&                 verbsd-configs-user.sh 2> /dev/null \
    ||               ./verbsd-configs-user.sh
  [ ${?} -eq 0 ] && :> verbsd-configs-user.sh.LOCK
fi

# COMPAT UBUNTU
if [ ! -f              verbsd-compat-ubuntu.sh.LOCK ]
then
  [ ${?} -eq 0 -a -e   verbsd-compat-ubuntu.sh ] \
    &&                 verbsd-compat-ubuntu.sh 2> /dev/null \
    ||               ./verbsd-compat-ubuntu.sh
  [ ${?} -eq 0 ] && :> verbsd-compat-ubuntu.sh.LOCK
fi

# ~/gfx/wallpapers
# ~/scripts
# ZSH CONFIG
