#!/bin/sh
#
# Copyright © 2011-2013 Martin Tournoij <martin@arp242.net>
# See below for full copyright
#
# Version: 20130313
# http://code.arp242.net/pkg_sanity
#

_usage()
{
  echo "Usage: ${0##*/} -o | -l | -u"
  echo ""
  echo " Commands:"
  echo "    -o    Check for binaries/libraries belonging to different FreeBSD versions"
  echo "          than what we’re currently running"
  echo "    -l    Check for unresolvable shared libraries"
  echo "    -u    Check for files that don't seem to belong to any package in ${localbase}"
  echo "          Be *very* careful removing files, some files are not directly listed in a"
  echo "          package, but *are* required (eg. cache files)."
  echo "          It's also increasingly common to install {ruby,nodejs,..} packages directly"
  echo "          with the provided packaging tools (eg. gem, npm, easy_install)"
  echo ""
  echo " Options:"
  echo "    -v    Verbose output"
  echo ""
}

_binaries()
{
  local version bindirs dir f

  [ ! -z ${verbose} ] && echo "===> Checking for old binaries"

  version=$(uname -r | cut -d'.' -f1)
  bindirs="bin sbin"

  for dir in ${bindirs}; do
    [ ! -z ${verbose} ] && echo "${localbase}/${dir}"

    for f in ${localbase}/${dir}/*; do
      file "${f}" | grep 'ELF' | grep -v "FreeBSD ${version}"
      [ $? -eq 0 ] && error=yes
    done
  done
}

_libraries()
{
  local libdirs dir f check pkgname

  [ ! -z ${verbose} ] && echo "===> Checking for unresolvable libraries"

  libdirs="/bin /sbin /libexec /lib /usr/bin /usr/sbin /usr/lib /usr/libexec \
  ${localbase}/bin ${localbase}/sbin ${localbase}/lib ${localbase}/libexec"

  for dir in ${libdirs}; do
    [ ! -z ${verbose} ] && echo "Checking ${dir}"
    for f in $(find ${dir} -type f); do
      # LD_TRACE_LOADED_OBJECTS is needed for Linux binaries
      # http://www.freebsd.org/cgi/query-pr.cgi?pr=bin/127276
      check=$(LD_TRACE_LOADED_OBJECTS=y ldd "${f}" 2>&1 | grep -v "not a dynamic" | grep "found")
      if [ $? -eq 0 ]; then
        if [ ${pkgng} -eq 0 ]; then
          pkgname=$(pkg which "${f}" | cut -d' ' -f6)
        else
          pkgname=$(pkg_info -W "${f}" | cut -d' ' -f6)
        fi
        echo "Found a problem in ${f} (Part of ${pkgname})"
        echo "${check}"
      fi
    done
  done
}

_unowned()
{
  local pkgfiles_tmpfile files_tmpfile pkgnum filenum missing unknown \
    nummissing numunknown

  [ ! -z ${verbose} ] && echo "===> Checking for unowned files"

  pkgfiles_tmpfile=$(mktemp -t pkg_sanity)
  files_tmpfile=$(mktemp -t pkg_sanity)

  trap "rm ${pkgfiles_tmpfile} ${files_tmpfile}; exit 1" INT

  # Get list a files that should be installed
  if [ ${pkgng} -eq 0 ]; then
    pkg info -la | grep '^/' | sort -u > "${pkgfiles_tmpfile}"
  else
    grep -Ev '(^@|^\+)' | ${pkgdb}/*/+CONTENTS | sort -u > "${pkgfiles_tmpfile}"
  fi
  pkgnum=$(wc -l "${pkgfiles_tmpfile}" | cut -d' ' -f 4)

  # Get a list of everything in /usr/local/
  find ${localbase} -type f -or -type l | sed "s|^${localbase}/||;" \
    | sort -u > ${files_tmpfile}
  filenum=$(wc -l "${files_tmpfile}" | cut -d' ' -f 4)

  # Let's diff!
  missing=$(diff -u00 ${pkgfiles_tmpfile} ${files_tmpfile} \
    | grep '^[-][^+-]' | sed "s|^-|${localbase}/|")
  unknown=$(diff -u00 ${pkgfiles_tmpfile} ${files_tmpfile} \
    | grep '^[+][^+-]' | sed "s|^\+|${localbase}/|")

  # Ignore Python & Perl cache files
  unknown=$(echo "${unknown}" | grep -Ev '(\.pyc|\.pyo|\.ph)$')

  nummissing=$(echo "${missing}" | wc -l | cut -d' ' -f 4)
  numunknown=$(echo "${unknown}" | wc -l | cut -d' ' -f 4)

  # TODO: these numbers are off if you have linux- ports
  #echo "===> Files in pkgdb:       ${pkgnum}"
  #echo "===> Files in filesystem:  ${filenum}"
  #echo "===> Difference:          " $((${filenum} - ${pkgnum}))

  # TODO: Also print package
  if [ "${nummissing}" != "0" ] || [ ! -z ${verbose} ]; then
    echo "===> Files that should be installed but are not: ${nummissing}"
    echo "${missing}"
    echo ""
  fi

  if [ "${numunknown}" != "0" ] || [ ! -z ${verbose} ]; then
    echo "===> Unknown files in ${localbase}: ${numunknown}"
    echo "${unknown}" | grep -v "${localbase}/etc/"
  fi

  rm ${files_tmpfile} ${pkgfiles_tmpfile}
}

localbase=${LOCALBASE:=/usr/local}
pkgdb=${PKGDB:=/var/db/pkg}
[ -f ${pkgdb}/local.sqlite ] && [ "X$(make -V WITH_PKGNG)" != "X" ]
pkgng=$?

# Make sure localbase doesn't have a trailing slash
localbase=$(echo "${localbase}" | sed -e 's|//|/|g; s|/$||;')

c=0
while getopts "holuv" arg; do
  case "${arg}" in
    h) _usage; exit 0 ;;
    o) binaries=yes; c=1 ;;
    l) libraries=yes; c=1 ;;
    u) unowned=yes; c=1 ;;
    v) verbose=yes ;;
    *) _usage; exit 1 ;;
  esac
done

if [ ${c} -eq 0 ]; then
  _usage
  exit 1
fi

[ -n "${binaries}" ] && _binaries
[ -n "${libraries}" ] && _libraries
[ -n "${unowned}" ] && _unowned

if [ -z ${error} ]; then
  exit 0
else
  exit 1
fi


# The MIT License (MIT)
#
# Copyright © 2011-2013 Martin Tournoij
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# The software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising
# from, out of or in connection with the software or the use or other dealings
# in the software.
