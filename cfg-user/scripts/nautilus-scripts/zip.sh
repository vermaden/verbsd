#! /bin/sh

zip -9 -y -r -q ARCHIVE-$( date +%Y-%m-%d-%H-%M-%S ).zip "${@}"
